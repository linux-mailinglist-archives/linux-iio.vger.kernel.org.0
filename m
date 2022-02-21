Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23C44BE16F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Feb 2022 18:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiBURbb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 21 Feb 2022 12:31:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiBURbP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Feb 2022 12:31:15 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C8A19C1A;
        Mon, 21 Feb 2022 09:30:50 -0800 (PST)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2Tnl3k3Jz6895J;
        Tue, 22 Feb 2022 01:29:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 21 Feb 2022 18:30:47 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 21 Feb
 2022 17:30:46 +0000
Date:   Mon, 21 Feb 2022 17:30:45 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 1/3] iio: dac: add support for ltc2688
Message-ID: <20220221173045.00003969@Huawei.com>
In-Reply-To: <YhPGJqEuTQ3TBy46@smile.fi.intel.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
        <20220121142501.151-2-nuno.sa@analog.com>
        <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
        <PH0PR03MB678628C341A1972BC31F5BBA992B9@PH0PR03MB6786.namprd03.prod.outlook.com>
        <YgD91zg4L1S5KH5k@smile.fi.intel.com>
        <e1bd9f14e63e55f48f804568705a9ab8c1a09f62.camel@gmail.com>
        <Ygpd7pebiuGuB8nT@smile.fi.intel.com>
        <11bd63bc07fd406bfa31bdc38b597011cc9312cc.camel@gmail.com>
        <YhImsJidUu2fMKgu@smile.fi.intel.com>
        <3f2523127eb320a9825e272353afea9673e5d003.camel@gmail.com>
        <YhPGJqEuTQ3TBy46@smile.fi.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Feb 2022 19:04:38 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Feb 21, 2022 at 01:48:12PM +0100, Nuno S� wrote:
> > On Sun, 2022-02-20 at 13:32 +0200, Andy Shevchenko wrote:  
> > > On Fri, Feb 18, 2022 at 02:51:28PM +0100, Nuno S� wrote:  
> > > > On Mon, 2022-02-14 at 15:49 +0200, Andy Shevchenko wrote:  
> > > > > On Mon, Feb 07, 2022 at 09:19:46PM +0100, Nuno S� wrote:  
> > > > > > On Mon, 2022-02-07 at 13:09 +0200, Andy Shevchenko wrote:  
> > > > > > > On Sun, Feb 06, 2022 at 01:19:59PM +0000, Sa, Nuno wrote:  
> > > > > > > > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > > > > > > Sent: Saturday, February 5, 2022 6:30 PM
> > > > > > > > > On Fri, Jan 21, 2022 at 03:24:59PM +0100, Nuno S� wrote:  
> 
> ...
> 
> > > > > > > > > > +�������ret = kstrtou16(buf, 10, &val);  
> > > > > > > > > 
> > > > > > > > > In other function you have long, here u16. I would expect that
> > > > > > > > > the types are of the same class, e.g. if here you have u16,
> > > > > > > > > then there something like s32 / s64.  Or here something like
> > > > > > > > > unsigned short.
> > > > > > > > > 
> > > > > > > > > A bit of elaboration why u16 is chosen here?  
> > > > > > > > 
> > > > > > > > Well, I never really saw any enforcement here to be honest
> > > > > > > > (rather than using stdint types...). So I pretty much just use
> > > > > > > > these in unsigned types because I'm lazy and u16 is faster to
> > > > > > > > type than unsigned short...  In this case, unless Jonathan really
> > > > > > > > asks for it, I prefer not to go all over the driver and change
> > > > > > > > this...  
> > > > > > > 
> > > > > > > This is about consistency. It may work as is, but it feels not good
> > > > > > > when for int (or unsigned int) one uses fixed-width types. Also
> > > > > > > it's non- written advice to use fixed-width variables when it's
> > > > > > > about programming registers or so, for the rest, use POD types.  
> > > > 
> > > > Ok, going a bit back in the discussion, you argued that in one place I
> > > > was using long while here u16. Well, in the place I'm using long, that
> > > > was on purpose because that value is to be compared against an array of
> > > > longs (which has to be long because it depends on CCF rates). I guess I
> > > > can als0 use s64, but there is also a reason why long was used.
> > > > 
> > > > In the u16 case, we really want to have 2 bytes because I'm going to use
> > > > that value to write the dac code which is 2 bytes.  
> > > 
> > > Okay, that's what I want to hear. If it's indeed goes to be a value to the
> > > register, then it's fine.
> > > 
> > > Perhaps a comment?  
> > 
> > I guess you mean to have a comment to state that here we have fixed
> > size type (as opposed to long, used in another place), because we
> > directly use the value on a register write?
> > 
> > Asking it because I'm not planning to add comments in all the places
> > where I have fixed size types for register read/writes...  
> 
> Thinking more about it and now I'm convinced that using the value that goes to
> the register in ABI is bad idea (means that user space must not care about the
> size or contents of the hardware register and should be abstract representation
> of the HW).
> 
> OTOH this seems to be "raw" value of something. So, I maybe missed the convention
> in IIO about this kind of values WRT the variable types used on ABI side.
> 
> That said, I leave it to Jonathan since I'm not convinced that u16 is a proper
> choice here.

From a userspace point of view it doesn't care as it's writing a string.
In this particular case the string only has valid values that from 0-(2^16-1)
(i.e. 16 bits).  So if it writes outside of that range it is an error.
You could read it into an unsigned long and then check against the range,
but there is little point given you'd still return an error if it was out of
range.  The fact that kstrto16() does that for you really just a shortcut
though it will return -ERANGE rather than perhaps -EINVAL which might be used
for a more generic "not this value".

Userspace can also read the range that is acceptable from
out_voltage0_raw_available [0 1 2^16-1] and hence not write an invalid value
in the first place - which is obviously preferred to getting an error.
Scaling etc is also expressed to userspace so it it wants to write a particular
voltage it can perform the appropriate scaling. Note that moving linear scaling
like this to userspace allows easy use of floating point + may be a significant
performance advantage if using the chrdev interface which uses the same
approach (and values) as the sysfs interface.

Jonathan


 
> 
> > > > > > I can understand your reasoning but again this is something that I
> > > > > > never really saw being enforced. So, I'm more than ok to change it if
> > > > > > it really becomes something that we will try to "enforce" in IIO.
> > > > > > Otherwise it just feels as a random nitpick :).  
> > > > > 
> > > > > No, this is about consistency and common sense. If you define type uXX,
> > > > > we have an API for that exact type. It's confusing why POD type APIs
> > > > > are used with fixed-width types or vise versa.
> > > > > 
> > > > > Moreover (which is pure theoretical, though) some architectures might
> > > > > have no (mutual) equivalency between these types.  
> 

