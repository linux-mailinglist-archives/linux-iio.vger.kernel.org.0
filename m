Return-Path: <linux-iio+bounces-22644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EBBB2435C
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 09:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0777418817D7
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 07:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DBA2E3B17;
	Wed, 13 Aug 2025 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx4LG8lH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A62E36F4;
	Wed, 13 Aug 2025 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071653; cv=none; b=nDlIDVzWIWAj3PQzYiQr22HqrozZlB819xwPmKVl+5GlYyEME2PsQKFlBYMsNUCEEwPkZYvRB0/InQAVpc0yzwYB6G2MlqGPOQfSLeHwFu46igZ0gEKupftfXfZ0ldO0hIV2MICuNj9nOpEMaxF8WzDPNRgh6JESC1s4FpOe4AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071653; c=relaxed/simple;
	bh=Se+R3SRBnQAUbFZPplFYB0lmjvDbELTuqeQUIydxg5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pa8yXX2/ZtlSFbVV4bBVbHym+0FEApO/OMYfwgy/wuEA+DxSKh3EpyzAo0U5BzglMOjvsSzOp/Y35y5iB2Vo/7Bk24RuxYcftq09qRJpcIv73QKYeMuQvOP7xgQ0daUMOchSFW53Lu9TsJDPohBKhWHTucX7PTlv8RlPGr+wGvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx4LG8lH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e8248ee36cso554266985a.2;
        Wed, 13 Aug 2025 00:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755071650; x=1755676450; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2UybIz5RKzn5qYjRcunlta4nxb7ffklkg0o7NA7aXmE=;
        b=Rx4LG8lHY2SX6BknK5UstA3nbosQEjZ0XbqJ+RlP6ObJ8bI2vJcON7NVsh0hIWjcbN
         ovfmi2hhoGqbdCTa3IoOaQNIbh5zELM/MDeXCkcPo7kt9Fj6Mq0Kbx7BvMOdi0VaLqiV
         EIYJDL7BTIE3p66Ln1Thg41F1gUBLowQDIv1TntTWjZItJUw8nzcIx8dchMxtrycDmyz
         wDhyL7b7N2FWRIACbWTB00NAFzg1STfi+ow0F42TvYHrpGSvDP/N5jjvAcb9H7eTo+PW
         UWeJ2V/F3/yX7e8ajZ4mbqwN9YVGzqxNjqr9T6JHYvx//q/joyLoBF4Q5N8BIF/GuPy5
         kHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071650; x=1755676450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UybIz5RKzn5qYjRcunlta4nxb7ffklkg0o7NA7aXmE=;
        b=ZzWlKRWXD899iEziaOMDO/vLi6icw3q70UHDlvkRLEV2Osk3XY3lTFcLmU/zBWWypY
         rHEGQTeHB0ICy/UmybFzPcuTz9wyKfWdfuGpPPEIPZV27aHqPT3/ojwOYbSsjZ6l1Tis
         04VsB6rX7Jm/2F6iLGuWKgleRTnBvMdeKJ/qwjaMAJprrgS/SIQ0wHNEbn48RK7IDnQK
         FdA/SQej6U5dS2GmGytjU6auDEa270lgTscmPh65+Zc3NcyUxj5+kym6Zx+gLKzct069
         /8vh7V5OC0AwE3ZBey+obGFz+VgnE6Pi91KprIDmWsj+P3pHh3EizTsvq2HIihtny8nG
         Wptg==
X-Forwarded-Encrypted: i=1; AJvYcCWrsjb+ex1BIhsQsrjQrKyFk5PQenpFP1dvWC30kG/ti4bSIP+PsFCuvfsRpaE3QTCRXKhgkTn2XqtNTy/i@vger.kernel.org, AJvYcCWsYJBfgjMOHwVEKqVtBqV0sEvNfj4nnUtYbeCiazSnnNCekgCXyE6tghkEYNvJq8wIf3TEJxG6IDDl@vger.kernel.org, AJvYcCX5WtBNCcqtthngkLJVrcd5KCGoP4InfrqwAjcUAa1vZHUKQwzVVA6AQ+ncelIYZirywYBRQyChPAcd@vger.kernel.org
X-Gm-Message-State: AOJu0YyuSwjcgZuk1qror0KD6W4DXINIIldI8blQAyDF7M42lmJopkrn
	WCokmB2ZfItVVmzbqhsA6ky3vA78icaofoAJ2x3eKAjo3jkrItFGO12l
X-Gm-Gg: ASbGncsAYPOS3qK7NBmp00wEGvAuVLErx4PrRvVZr9l4WN3l1zkGrSAKanTgiJ5z2gH
	c6oJ/7ZZX03MyrzpqiwiqZGsFVJVmANQxf/HLcsyKkT8ozCCuq+jAXJsyZ3T7943b3nCOBz9Zr4
	BI3rtJhiiI6K+cuth1HvNhv9Ej5CA/xJanP16gEQ92xWZDofWOwjnIf7n6opKj1hy3ga7Ge6Mj4
	farHA6Y97Vu43oWc47KFF51QRrsuemx/6lo191Q+DQeLRs3aBfw8TlVu6sc7zo9TC4xXdzELFKT
	IUKd55jmHUMWWCFuw8hxBkQ740kL/M5qdNlLJjAq3IuWwadvaIEeC4Y7zPgIiRkyDdNjXLqjeuT
	an/9shmPo2/s=
X-Google-Smtp-Source: AGHT+IG43rF9yFYmKpQf+pkO92Bo4veU5NRhAxmIcO1Unuk2b5QG17zeBJ5XdkFwEaFlvk0TdGVUZQ==
X-Received: by 2002:a05:620a:d5b:b0:7e3:46da:9e1f with SMTP id af79cd13be357-7e8653259d6mr242571085a.56.1755071650030;
        Wed, 13 Aug 2025 00:54:10 -0700 (PDT)
Received: from nsa ([45.88.190.11])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f595525sm1922281085a.2.2025.08.13.00.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 00:54:09 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:54:25 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: Replace bouncing Analog emails
Message-ID: <whi5if3mrfjtszczpgerdzv457iihcf6bbywbrt5i7javoap4u@dtgd4ncum4gt>
References: <20250812132445.75398-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250812132445.75398-2-krzysztof.kozlowski@linaro.org>

On Tue, Aug 12, 2025 at 03:24:46PM +0200, Krzysztof Kozlowski wrote:
> Emails to stefan.popa@analog.com and alexandru.tachici@analog.com bounce
> permanently:
> 
>   Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'
> 
> so replace them with Marcelo Schmitt and Nuno Sá (listed alphabetically
> by first name) from Analog where appropriate.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Acked-by: Nuno Sá <nuno.sa@analog.com>

> 
> Changes in v2:
> 1. Add Nuno, based on discussions on the list.
> 2. Add Rob's Ack.
> 
> This change got agreement on the list, but still would be nice if you
> folks Ack it formally.
> ---
>  Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml | 3 ++-
>  Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml   | 3 ++-
>  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml      | 3 ++-
>  Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml    | 1 -
>  Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml     | 3 ++-
>  Documentation/devicetree/bindings/iio/frequency/adf4371.yaml   | 3 ++-
>  Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml   | 3 ++-
>  7 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> index 3dc973b98f81..a92e153705f3 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ADIS16240 Programmable Impact Sensor and Recorder driver
>  
>  maintainers:
> -  - Alexandru Tachici <alexandru.tachici@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +  - Nuno Sá <nuno.sa@analog.com>
>  
>  description: |
>    ADIS16240 Programmable Impact Sensor and Recorder driver that supports
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> index 88aa67bf2280..0ba0df46c3a9 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
>  
>  maintainers:
> -  - Stefan Popa <stefan.popa@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +  - Nuno Sá <nuno.sa@analog.com>
>  
>  description: |
>    Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer that supports
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> index 7146a654ae38..4dd5395730c1 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> @@ -8,7 +8,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices AD7124 ADC device driver
>  
>  maintainers:
> -  - Stefan Popa <stefan.popa@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +  - Nuno Sá <nuno.sa@analog.com>
>  
>  description: |
>    Bindings for the Analog Devices AD7124 ADC device. Datasheet can be
> diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> index 5207c919abe0..eac48166fe72 100644
> --- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> @@ -9,7 +9,6 @@ title: Linear Technology / Analog Devices LTC2496 ADC
>  maintainers:
>    - Lars-Peter Clausen <lars@metafoo.de>
>    - Michael Hennerich <Michael.Hennerich@analog.com>
> -  - Stefan Popa <stefan.popa@analog.com>
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> index 82b0eed6a7b7..091cc93f1f90 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> @@ -8,7 +8,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices AD5770R DAC device driver
>  
>  maintainers:
> -  - Alexandru Tachici <alexandru.tachici@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +  - Nuno Sá <nuno.sa@analog.com>
>  
>  description: |
>    Bindings for the Analog Devices AD5770R current DAC device. Datasheet can be
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> index 53d607441612..2e1ff77fd1de 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices ADF4371/ADF4372 Wideband Synthesizers
>  
>  maintainers:
> -  - Popa Stefan <stefan.popa@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +  - Nuno Sá <nuno.sa@analog.com>
>  
>  description: |
>    Analog Devices ADF4371/ADF4372 SPI Wideband Synthesizers
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> index 7a1a74fec281..43ecf46e9c20 100644
> --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices ADIS16480 and similar IMUs
>  
>  maintainers:
> -  - Alexandru Tachici <alexandru.tachici@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +  - Nuno Sá <nuno.sa@analog.com>
>  
>  properties:
>    compatible:
> -- 
> 2.48.1
> 

