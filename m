Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 982B6F20E1
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2019 22:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfKFVg0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Nov 2019 16:36:26 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:19014 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfKFVg0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Nov 2019 16:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573076182;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=gSa0ioulMx/V4tV8aaGPUTKbe/GC25k6evW5ZAAORck=;
        b=DyaHHUXK8uFvd/lUExHP2ldvY5VhA8A/RhcuN7af9HB/zCLwhxxsbD733sHnyx/J8C
        nT6dnFw5PKLaC690Xxk60QKOgNA2Ur+xPxILn0q/RcsBxlRkkZqm1ZOAeB9E4rFsU1Mp
        P56wiQdpm1xgmctEdFZQp1GGsXY8YnL+viEVK9B9sFJ1ly1MkySw/9n93p2ZmS5gaR5V
        fX3THtuB3LoAl9CdApZXwPXZTqKCoiBg680bxotmbUK1ZDah/eGRLqNSLX26X49EK35u
        4AeDgJZ7HBqVOHVOZJU+TXCOyeeELh2CV7+pQNGm7699YzYfSdaS8zc0rSV9IoeMsqzG
        LlOQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJAS+MtXUdD"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vA6LaJiDR
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 6 Nov 2019 22:36:19 +0100 (CET)
Date:   Wed, 6 Nov 2019 22:36:16 +0100
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
Message-ID: <20191106213359.GA130672@gerhold.net>
References: <20191106183536.123070-1-stephan@gerhold.net>
 <20191106183536.123070-2-stephan@gerhold.net>
 <MN2PR12MB3373CA676226F02BE0C804A8C4790@MN2PR12MB3373.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR12MB3373CA676226F02BE0C804A8C4790@MN2PR12MB3373.namprd12.prod.outlook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi JB,

On Wed, Nov 06, 2019 at 07:55:20PM +0000, Jean-Baptiste Maneyrol wrote:
> Hello Stephan,
> 
> nice patch but I have an important concern.
> 
> We are calling the core_enable/disable_regulator functions when going into suspend and resume.
> With your changes, we are going to power down the chip when going into suspend and then power it up again.
> This way we will loose all already set configuration, like FSR, sampling rate, init values, ...
> The chip will not be able to work correctly anymore after a suspend-resume cycle.
> 
> You need to change the resume/suspend handlers to only disable/enable the vddio regulator, not the vdd one.

That is a good point, thanks!
I guess we are not able to use the regulator bulk API in this case...

I will send a v2 soon.

Stephan
