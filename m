Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D49F36B1
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 19:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfKGSMH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Nov 2019 13:12:07 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:32539 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfKGSMH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Nov 2019 13:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573150325;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=wlYx0jYIMA60CF4+HfsceKorAaRJb8L+ckAK3oldZp4=;
        b=Q+i+RF/W1DmjZLSFNL2y/Us5oLQemnoWRUGRohti3x59yv/RlRz65WwiP2GH94Lwu8
        rkh/hO+nBSNhyKEKdZxR4/Z75jl4Z02dV8m51/V2luI/mwhrkkip8UIGWiD74OXXXDJN
        jbIMe7kqrdAezzrZglbh0tAhpEzoAheScQxSDj67kLDNpZ5K3YGDkmqXzg629qA26GrG
        pYYcNssYQPYhaFu2lI+FK7TNvAu5x6sOVD4DZMRqrLKpvrlhmxlLCyFNEyGFgXZ5p6zJ
        oQl6WZGiUl8jnd2kK+40TKSWH0jJL67rZbMSXV8w95LqlQ/ZlJed0QaX1DPhzSIlxnKF
        r2Cg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJDd+zEsL6f"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vA7IC3oLV
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 7 Nov 2019 19:12:03 +0100 (CET)
Date:   Thu, 7 Nov 2019 19:12:00 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: mpu6050: Add support for vdd-supply
 regulator
Message-ID: <20191107181140.GA908@gerhold.net>
References: <20191106183536.123070-1-stephan@gerhold.net>
 <20191106183536.123070-2-stephan@gerhold.net>
 <MN2PR12MB3373CA676226F02BE0C804A8C4790@MN2PR12MB3373.namprd12.prod.outlook.com>
 <20191106213359.GA130672@gerhold.net>
 <MN2PR12MB3373846E85AA1A396198F46EC4780@MN2PR12MB3373.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR12MB3373846E85AA1A396198F46EC4780@MN2PR12MB3373.namprd12.prod.outlook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 07, 2019 at 01:29:33PM +0000, Jean-Baptiste Maneyrol wrote:
> Hi Stephan,
> 
> I think the regulator_bulk usage is good, and the core_enable/disable_regulator functions implemented the way you did is perfect for the init/shutdown phase.
> 
> We just need to change the suspend/resume implementation to use something different.

As far as I can tell, the regulator bulk API is designed to be used when
you want to enable/disable multiple regulators at the same time.
It does not really allow controlling one of its regulators separately
(in a clean way).

E.g. if you would use regulator_bulk_disable() but already disabled one
of the regulators at some point earlier, you would run into a warning
because the regulator is disabled twice.

My updated patch is still clean enough (in my opinion), so I would say
it is better to avoid the regulator bulk API for this situation.
I will send v2 shortly.

Thanks,
Stephan
