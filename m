Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCCA1E2CCD
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 21:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392224AbgEZTRr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 26 May 2020 15:17:47 -0400
Received: from balrog.mythic-beasts.com ([46.235.227.24]:50807 "EHLO
        balrog.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389654AbgEZTRo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 15:17:44 -0400
Received: from [2a00:1098:80::1:1] (port=36112 helo=erriapus.retrosnub.co.uk)
        by balrog.mythic-beasts.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1jdf4t-0006zj-6U; Tue, 26 May 2020 20:17:31 +0100
Received: from [192.168.0.10] (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by erriapus.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 5BF033A010C;
        Tue, 26 May 2020 20:17:10 +0100 (BST)
Date:   Tue, 26 May 2020 20:17:11 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20200526170612.GY1634618@smile.fi.intel.com>
References: <20200525170628.503283-1-jic23@kernel.org> <20200525170628.503283-20-jic23@kernel.org> <20200525175236.GG1634618@smile.fi.intel.com> <da67e0e4-5889-eb87-7bc0-fac07ae54e57@metafoo.de> <20200526091556.GN1634618@smile.fi.intel.com> <20200526174328.0000673d@Huawei.com> <20200526170612.GY1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 19/25] iio:adc:ti-ads1015 Fix buffer element alignment
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <E1CB2D23-5B37-47E7-8782-ACC296EE5712@jic23.retrosnub.co.uk>
X-Mythic-Source-External: YES
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 26 May 2020 18:06:12 BST, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>On Tue, May 26, 2020 at 05:43:28PM +0100, Jonathan Cameron wrote:
>> On Tue, 26 May 2020 12:15:56 +0300
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> > On Tue, May 26, 2020 at 10:11:44AM +0200, Lars-Peter Clausen wrote:
>> > > On 5/25/20 7:52 PM, Andy Shevchenko wrote:  
>> > > > On Mon, May 25, 2020 at 06:06:22PM +0100, Jonathan Cameron
>wrote:  
>> > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
>
>...
>
>> > > > > +	struct {
>> > > > > +		s16 channel;
>> > > > > +		s64 ts;
>> > > > > +	} scan;  
>> > > > Hmm... On x86_32 and x86_64 this will give different padding.
>Is it okay from
>> > > > iio_push_to_buffers_with_timestamp() point of view?  
>> > > 
>> > > No, this is terrible. IIO expects 64 bit words to be 64 bit
>aligned. Looks
>> > > like we can't rely on implicit padding, but need to always
>explicitly
>> > > specify it.
>> > > 
>> > > Or maybe we can typedef and IIO timestamp type with an explicit
>__aligned
>> > > attribute. I wonder if that works... After having a quick look,
>the kernel
>> > > already defines aligned_u64, so maybe using that is an option.  
>> > 
>> > Another way is simple to provide offset of timestamp member as a
>parameter.
>> > Though, if it's an ABI, then alas, we need to align it properly.
>> > 
>> > Also, wouldn't be better to explicitly show the padding?
>> > 
>> > 	struct {
>> > 		s16 channel;
>> > 		s16 padding[3];
>> > 		s64 ts;
>> > 	} scan;
>> > 
>> > (matter of style though, just saying).
>> > 
>> 
>> gah.  Thanks for pointing this out Andy.  I wanted to avoid
>explicitly
>> calling out empty padding because it seemed to me to be more likely
>to
>> be error prone than filling it in.
>> 
>> I was trying to avoid using __aligned on the stack as it only works
>for
>> more recent kernels (due to gcc version changes) and some of these
>predate
>> that point.
>> 
>> I guess we just do it explicitly in all these cases.
>> 
>> The two patches that have already gone to Greg both have sufficient
>> data to ensure the structure is big enough (only 16 bytes padding in
>one and
>> none in the other).
>> 
>> I think we are also fine for the original question as well as it
>won't
>> matter if the whole structure is aligned to 4 bytes on x86_32 and
>> similar as an 8 byte write will be fine.
>> 
>> So fun question - do we want to enforce 8 byte alignment of the whole
>> structure, or simply the padding?
>> 
>> Maybe better to just do the padding explicitly as Andy suggested.
>
>I have talked to colleague of mine, and we concluded (but without any
>documentation proved evidence, one needs basically to read C standard
>followed
>by ABI of all architectures supported by Linux) that the following will
>work.
>
>Consider your patch, which introduces natural alignment via struct:
>
>	struct scan {
>		s16 ...;
>		...
>		s64 ts;
>	};
>
>When we access ts as struct member like scan->ts, compiler makes sure
>that
>there will be no hardware exception (due to unaligned access). Now, we
>_assume_
>that dereferencing like
>
>	void *buf = &scan;
>	(int64_t *)buf[ts_offset] = value;
>
>will work flawlessly because above.
>
>If it's indeed a case, what we simple need is to pass ts offset into
>iio_push_to_buffers_with_timestamp().

Realistically it might work but doesn't help us. We need all receivers of that buffer to
 know the location of ts.  It has always been implicit like any other channel. 
 Rules are natural alignment so alignment is same as size of element. 

Hence we need to ensure padding, but I'm not sure about alignment.  If padding was
right for 8 byte alignment but whole structure had 4 byte alignment then I think we
 should be fine. So slightly more relaxed the ensuring ts is 8 byte aligned. 

Might be easier to just align it though than explain this subtlety. 

J


>
>If it's not the case, we _additionally_ will need to replace
>	(int64_t *)buf[ts_offset] = value;
>by
>	put_unaligned(value, (int64_t *)...);

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
