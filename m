Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1689947FE35
	for <lists+linux-iio@lfdr.de>; Mon, 27 Dec 2021 16:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhL0PYU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Dec 2021 10:24:20 -0500
Received: from vern.gendns.com ([98.142.107.122]:54302 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230158AbhL0PYU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Dec 2021 10:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vwpNxfqc5U+R/s2bi4W5OYEUuR96ZclWDFMsUuoacRs=; b=crRav70GOJTaHnvlkXLORDLyIL
        iw/GlsFl/VigsHxZon/Qm/cIiJsquP2iMWhpWiPaSbCY4q8FDl3Jc3tuNhnV0KIVVbNbs00p/a1cK
        Cx3QIy5Kuyd7yLAa3DrDCPN08LF6VpyKwdgYd/a6KHKYpocUWTM5txzqjJm7PPbeQwSAzFcavxIHo
        iog5P4m1lkZc5zhleGfNNWzRjC/rnfQhhpbHLCrme6pQfM2n2tJevpvw2xpSTVVg5bGHgzuA30xF/
        PCi5hxydF5nvmVkRkBoWicRKdux6ObT7x6vWnIoME7/mEhPsyZTgiKRR27qzIg28yWEW0jVG7uMh5
        teTdrf9A==;
Received: from [2600:1700:4830:1658::fb2] (port=56212)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1n1rrB-0006gh-Ho; Mon, 27 Dec 2021 10:24:16 -0500
Subject: Re: [PATCH v1 00/23] counter: cleanups and device lifetime fixes
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Raymond Tan <raymond.tan@intel.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Patrick Havelange <patrick.havelange@essensium.com>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
 <20211225192038.amgzrvkeyjgzzbuz@pengutronix.de>
From:   David Lechner <david@lechnology.com>
Message-ID: <63e59329-24b9-989b-ebf5-589e2f36e866@lechnology.com>
Date:   Mon, 27 Dec 2021 09:24:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211225192038.amgzrvkeyjgzzbuz@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/25/21 1:20 PM, Uwe Kleine-König wrote:
> Hello,
> 
> some sidestory to this series: While working on fixing the struct dev
> lifetime thing, I saw a few ugly things that I don't intend to fix
> myself. Here is just a mail to let you know this with a list of issues.
> Feel free to address or ignore:
> 
>   - 104_QUAD_8 depends on X86, but compiles fine on ARCH=arm. Maybe
>     adding support for COMPILE_TEST would be a good idea.
> 
>   - 104-quad-8.c uses devm_request_irq() and (now) devm_counter_add(). On
>     unbind an irq might be pending which results in quad8_irq_handler()
>     calling counter_push_event() for a counter that is already
>     unregistered. (The issue exists also without my changes.)
> 
>   - I think intel-qep.c makes the counter unfunctional in
>     intel_qep_remove before the counter is unregistered.
> 
>   - I wonder why counter is a bus and not a class device type. There is
>     no driver that would ever bind a counter device, is there? So
>     /sys/bus/counter/driver is always empty.

This last item has been brought up before. The conclusion was yes it
should have been a class but it is too late to change it now since it
would break userspace.

(I think bus was cargo-culted from the iio subsystem.)
