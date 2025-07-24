Return-Path: <linux-iio+bounces-21960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08715B1093B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC44F3ABB5B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ECD27D77D;
	Thu, 24 Jul 2025 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6aNhcAM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBD2652A6;
	Thu, 24 Jul 2025 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356660; cv=none; b=D6A+C+GAKK3fcl0N/jwlvwBsczgPJUzKhSNbs5hilcrGRKeDEEshAbs3V47njIKug7NbBet1QRXsjRE2KUGTKUrX9AZTbFTHgr66bULXW9eEeOlAHlP3i4P7H7MnPHc+wxOTKwNV6zrU0770ECNvVEBZqvTTOXQVmW2Ssb03PfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356660; c=relaxed/simple;
	bh=tZJLscCqA8Q9oa625+lNcp1oIJSRRSVUd2ToPL84ReM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzMVv5eRVFPbVShWirI7ty86bD0HPpnMT5kmr+s1YSCGlDt/6juyBanYM+477WMzPhUtRqvBHu7V+AfgpLXL6No8Ru1WQhQ33qo9zUbou8mMSwEdfkZa3uYOyjw1Hkd8KYjEg7ada2BgAPR9dbSyDkt265p44lE1WC+SCVBX3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6aNhcAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65C2C4CEED;
	Thu, 24 Jul 2025 11:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753356660;
	bh=tZJLscCqA8Q9oa625+lNcp1oIJSRRSVUd2ToPL84ReM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R6aNhcAM77Ul39OMm/QyrnbykO5KFV2b1iRlNzIrWitODpTdfwqfFzOdjZxwQ1xQE
	 sI65xFztuHuSGZUFX3391fN6Uk+7V+EJf8thLTz847WjW6688DayZ97Gj9ZmbBrOj5
	 eTWERg+kICVsu3cTu2Kep0hw/kcphAoQX7X4Wyh9kmmz8mqwbKQhlNw8stWgRJdsg7
	 msdMhsVlfm7wzy/h5GlRy3/9XBY21zATTNj2zB7YCZ0/tZYTR0FUSou5jcceKM8JH7
	 +oQxatV3zgCm1j/hdD3OAPiemIZRIa4r7QJGJ7+lTbAMQOehTB2xOm/3pO1rpG1B6G
	 yi/JsnKoIc84g==
Date: Thu, 24 Jul 2025 12:30:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lucas Stankus <lucas.p.stankus@gmail.com>, Puranjay
 Mohan <puranjay@kernel.org>, Dan Robertson <dan@dlrobertson.com>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Alim Akhtar
 <alim.akhtar@samsung.com>, Dragos Bogdan <dragos.bogdan@analog.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, =?UTF-8?B?T25k?=
 =?UTF-8?B?xZllag==?= Jirman <megi@xff.cz>, Alexandru Tachici
 <alexandru.tachici@analog.com>, Stefan Popa <stefan.popa@analog.com>, Linus
 Walleij <linus.walleij@linaro.org>, Stephan Gerhold <stephan@gerhold.net>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, Alexandru Lazar
 <alazar@startmail.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Angelo
 Compagnucci <angelo.compagnucci@gmail.com>, Mike Looijmans
 <mike.looijmans@topic.nl>, Manivannan Sadhasivam <mani@kernel.org>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, Andreas Klinger <ak@it-klinger.de>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: Drop unused header includes in
 examples
Message-ID: <20250724123046.4eced56f@jic23-huawei>
In-Reply-To: <d8be9f32-e78d-4a2d-8ab3-3c7d0bca4e3b@ixit.cz>
References: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
	<d8be9f32-e78d-4a2d-8ab3-3c7d0bca4e3b@ixit.cz>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 13:19:58 +0200
David Heidelberg <david@ixit.cz> wrote:

> Reviewed-by: David Heidelberg <david@ixit.cz>

I'm going to take the view these are utterly uncontroversial and pick them
up now (I'm trying to clear my review backlog).

Applied to the testing branch of iio.git which will be rebased on rc1
(so I can easily add tags etc)

Jonathan

> 
> On 24/07/2025 13:13, Krzysztof Kozlowski wrote:
> > Drop includes of headers which example code does not use.  No functional
> > impact.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >   Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml  | 1 -
> >   Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml    | 2 --
> >   Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml    | 2 --
> >   Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml    | 2 --
> >   Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml    | 2 --
> >   Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml   | 1 -
> >   Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml   | 1 -
> >   Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml   | 1 -
> >   Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml     | 1 -
> >   Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml       | 1 -
> >   Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml   | 1 -
> >   Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml     | 1 -
> >   Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml    | 1 -
> >   Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml       | 1 -
> >   Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml    | 1 -
> >   .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 --
> >   Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml     | 2 --
> >   Documentation/devicetree/bindings/iio/light/st,vl6180.yaml      | 1 -
> >   .../bindings/iio/magnetometer/voltafield,af8133j.yaml           | 1 -
> >   Documentation/devicetree/bindings/iio/pressure/bmp085.yaml      | 1 -
> >   20 files changed, 26 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > index 5887021cc90f..3dc973b98f81 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > @@ -37,7 +37,6 @@ unevaluatedProperties: false
> >   
> >   examples:
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       spi {
> >           #address-cells = <1>;
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> > index 0c5b64cae965..3a8c69eecfde 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> > @@ -57,7 +57,6 @@ unevaluatedProperties: false
> >   
> >   examples:
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       i2c {
> >           #address-cells = <1>;
> > @@ -73,7 +72,6 @@ examples:
> >           };
> >       };
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       spi {
> >           #address-cells = <1>;
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > index 84d949392012..a23a626bfab6 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > @@ -56,7 +56,6 @@ unevaluatedProperties: false
> >   
> >   examples:
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       i2c {
> >           #address-cells = <1>;
> > @@ -72,7 +71,6 @@ examples:
> >           };
> >       };
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       spi {
> >           #address-cells = <1>;
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> > index c07261c71013..f39e2912731f 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> > @@ -58,7 +58,6 @@ unevaluatedProperties: false
> >   
> >   examples:
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       i2c {
> >           #address-cells = <1>;
> > @@ -74,7 +73,6 @@ examples:
> >           };
> >       };
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       spi {
> >           #address-cells = <1>;
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> > index 62465e36a590..88aa67bf2280 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> > @@ -37,7 +37,6 @@ unevaluatedProperties: false
> >   
> >   examples:
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       i2c {
> >           #address-cells = <1>;
> > @@ -52,7 +51,6 @@ examples:
> >           };
> >       };
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       spi {
> >           #address-cells = <1>;
> > diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > index 457a709b583c..85c9537f1f02 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > @@ -107,7 +107,6 @@ examples:
> >           };
> >       };
> >     - |
> > -    # include <dt-bindings/interrupt-controller/irq.h>
> >       spi {
> >           #address-cells = <1>;
> >           #size-cells = <0>;
> > diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
> > index 8723a336229e..c5fedcf998f2 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
> > @@ -40,7 +40,6 @@ additionalProperties: false
> >   
> >   examples:
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       i2c {
> >         #address-cells = <1>;
> > diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
> > index f64d99b35492..53de921768ac 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
> > @@ -57,7 +57,6 @@ examples:
> >           };
> >       };
> >     - |
> > -    # include <dt-bindings/interrupt-controller/irq.h>
> >       spi {
> >           #address-cells = <1>;
> >           #size-cells = <0>;
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> > index ddec9747436c..705adbe88def 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> > @@ -93,7 +93,6 @@ unevaluatedProperties: false
> >   
> >   examples:
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       i2c {
> >           #address-cells = <1>;
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> > index 21ee319d4675..62d906e24997 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> > @@ -379,7 +379,6 @@ unevaluatedProperties: false
> >   examples:
> >     # Example AD7173-8 with external reference connected to REF+/REF-:
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >   
> >       spi {
> > diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> > index c28db0d635a0..b9dc04b0d307 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> > @@ -278,7 +278,6 @@ examples:
> >     - |
> >       #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> >       #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
> > -    #include <dt-bindings/interrupt-controller/irq.h>
> >   
> >       pmic {
> >           #address-cells = <1>;
> > diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
> > index 2a8ad4fdfc6b..f0a1347ba4db 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
> > @@ -50,7 +50,6 @@ unevaluatedProperties: false
> >   
> >   examples:
> >     - |
> > -    #include <dt-bindings/interrupt-controller/irq.h>
> >       spi {
> >           #address-cells = <1>;
> >           #size-cells = <0>;
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
> > index 775eee972b12..044b66a3b00c 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
> > @@ -44,7 +44,6 @@ unevaluatedProperties: false
> >   
> >   examples:
> >     - |
> > -    #include <dt-bindings/interrupt-controller/irq.h>
> >       spi {
> >           #address-cells = <1>;
> >           #size-cells = <0>;
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> > index bf5a43a81d59..71f9f9b745cb 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> > @@ -59,7 +59,6 @@ unevaluatedProperties: false
> >   
> >   examples:
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       spi {
> >           #address-cells = <1>;
> > diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> > index 4cacc9948726..3a725ece7ec4 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> > +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> > @@ -44,7 +44,6 @@ unevaluatedProperties: false
> >   
> >   examples:
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       spi {
> >           #address-cells = <1>;
> > diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> > index d4d4e5c3d856..119e28a833fd 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> > +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> > @@ -74,7 +74,6 @@ unevaluatedProperties: false
> >   
> >   examples:
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       i2c {
> >           #address-cells = <1>;
> > @@ -91,7 +90,6 @@ examples:
> >           };
> >       };
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       spi {
> >           #address-cells = <1>;
> > diff --git a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
> > index 688100b240bc..2930b3386703 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
> > +++ b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
> > @@ -47,7 +47,6 @@ unevaluatedProperties: false
> >   
> >   examples:
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       i2c {
> >           #address-cells = <1>;
> > @@ -63,7 +62,6 @@ examples:
> >           };
> >       };
> >     - |
> > -    #include <dt-bindings/gpio/gpio.h>
> >       #include <dt-bindings/interrupt-controller/irq.h>
> >       spi {
> >           #address-cells = <1>;
> > diff --git a/Documentation/devicetree/bindings/iio/light/st,vl6180.yaml b/Documentation/devicetree/bindings/iio/light/st,vl6180.yaml
> > index 27c36ab7990d..8598fb631aac 100644
> > --- a/Documentation/devicetree/bindings/iio/light/st,vl6180.yaml
> > +++ b/Documentation/devicetree/bindings/iio/light/st,vl6180.yaml
> > @@ -32,7 +32,6 @@ required:
> >   
> >   examples:
> >     - |
> > -    #include <dt-bindings/interrupt-controller/irq.h>
> >       i2c {
> >           #address-cells = <1>;
> >           #size-cells = <0>;
> > diff --git a/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml b/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
> > index b6ab01a6914a..ed42dc5afb99 100644
> > --- a/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
> > +++ b/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
> > @@ -44,7 +44,6 @@ additionalProperties: false
> >   
> >   examples:
> >     - |
> > -    #include <dt-bindings/interrupt-controller/irq.h>
> >       #include <dt-bindings/gpio/gpio.h>
> >       i2c {
> >           #address-cells = <1>;
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > index 706b7e24f182..b9ea37317b53 100644
> > --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > @@ -109,7 +109,6 @@ examples:
> >       };
> >     - |
> >       # include <dt-bindings/gpio/gpio.h>
> > -    # include <dt-bindings/interrupt-controller/irq.h>
> >       spi {
> >           #address-cells = <1>;
> >           #size-cells = <0>;  
> 


