Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 431F5F69A7
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 16:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfKJP2s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 10:28:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfKJP2r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 10:28:47 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A794620818;
        Sun, 10 Nov 2019 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573399727;
        bh=2K5uA5sMhb4u2sTiaobAwjmpIHyylWcEaZrKb50OjbE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sqEhwV+bc4UMgaLvMIQ8uMMTRepFOrqejgecpYy86K6FWdnnbi9oF7Gr+rvfSBjFT
         3i57hxTSxJ/UnCmbD5Fw/MFZ0KOB+HcKu2E7OTJB9eG6jlJ4M6lG1zbfyT7cwYZ9GT
         hrmEgBRcrAuSnEgDmI3xUOritOMCuI/fhPSOdtu8=
Date:   Sun, 10 Nov 2019 15:28:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imo: mpu6050: add vdd-supply
Message-ID: <20191110152841.6f6303c8@archlinux>
In-Reply-To: <20191107184342.20361-1-stephan@gerhold.net>
References: <20191107184342.20361-1-stephan@gerhold.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  7 Nov 2019 19:43:41 +0100
Stephan Gerhold <stephan@gerhold.net> wrote:

> inv_mpu6050 now supports an additional vdd-supply; document it.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Applied with imo->imu in the patch title.

Thanks,

Jonathan

> ---
> Changes in v2:
>   - Add Reviewed-by from Linus Walleij
> 
> v1: https://lore.kernel.org/linux-iio/20191106183536.123070-1-stephan@gerhold.net/
> ---
>  Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> index 268bf7568e19..c5ee8a20af9f 100644
> --- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> @@ -21,6 +21,7 @@ Required properties:
>    bindings.
>  
>  Optional properties:
> + - vdd-supply: regulator phandle for VDD supply
>   - vddio-supply: regulator phandle for VDDIO supply
>   - mount-matrix: an optional 3x3 mounting rotation matrix
>   - i2c-gate node.  These devices also support an auxiliary i2c bus.  This is

