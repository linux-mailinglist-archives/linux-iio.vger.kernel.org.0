Return-Path: <linux-iio+bounces-12018-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78679C1846
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 09:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D35B22211
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF7D1E0081;
	Fri,  8 Nov 2024 08:46:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DA81DED5A
	for <linux-iio@vger.kernel.org>; Fri,  8 Nov 2024 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055564; cv=none; b=kzMw+tpTmSzm4xKm3rj3RtK7+RFRddvrZ77YxcH5AlWK/7zLJ6gRg91NOHz03Lzk71ep7HOuFJv0rUAJSbANyhUty3NJT8teyQMOF6G8Q5fZDLCG0KtGJhW31kv26FpuateOwNsPThVNXwDiKivC+svug9rT0hfHl9qsGJwFG+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055564; c=relaxed/simple;
	bh=FaOK6/VoquYLDg3s64g2kbmOgn3XY3DLadlvoXBaMXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIIN8PpKdXq7wMgKeB04rqd/c/DTHB/H/C73ghCeRvIh6V0aS3ICOlmS7YuKjLTjvZNQPdasId6KHt5L0G7wY1cKHL2kq5FhBPUuZe6d7P9p+us3vgVdQ6zLv1bWgXVeH1vgo+ceMuqbACBzpnirC1n8uK31nLNsT66/DehttTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1t9Kcm-0001lQ-8f; Fri, 08 Nov 2024 09:45:48 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t9Kcl-002alM-2d;
	Fri, 08 Nov 2024 09:45:47 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t9Kcl-0004JW-2H;
	Fri, 08 Nov 2024 09:45:47 +0100
Date: Fri, 8 Nov 2024 09:45:47 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: trivial-devices: Add NXP P3T1085UK
 I3C/I2C temperature sensor
Message-ID: <20241108084547.dzmxgdwllwvbiw5n@pengutronix.de>
References: <20241107-p3t1085-v1-0-9a76cb85673f@nxp.com>
 <20241107-p3t1085-v1-1-9a76cb85673f@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107-p3t1085-v1-1-9a76cb85673f@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

On 24-11-07, Frank Li wrote:
> P3T1085UK is a temperature-to-digital converter with a -40 °C to +125 °C
> range. The device can be communicated by a controller via the 2-wire serial
> I3C (up to 12.5 MHz) and I2C (up to 3.4 MHz) interface.
> 
> Add it to trivial-devices.yaml because only one 'reg' and 'interrupts'
> needs.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 6ecd6432b021b..361943b3d73bc 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -301,6 +301,8 @@ properties:
>            - national,lm92
>              # Nuvoton Temperature Sensor
>            - nuvoton,w83773g
> +            # NXP I2C/I3C Temperature Sensor (-40 °C to +125 °C)
> +          - nxp,p3t1085

The description of this binding says:

"This is a list of trivial I2C and SPI devices ..."

but you add a I2C and I3C device.

Also I really like to see that you add a "power-supply" property which
is most the time missing for such simple devices but always required.

Regards,
  Marco

>              # OKI ML86V7667 video decoder
>            - oki,ml86v7667
>              # ON Semiconductor ADT7462 Temperature, Voltage Monitor and Fan Controller
> 
> -- 
> 2.34.1
> 
> 
> 

