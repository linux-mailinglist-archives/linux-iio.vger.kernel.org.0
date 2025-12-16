Return-Path: <linux-iio+bounces-27117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE14CC385D
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 15:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BC0A3055E1C
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 14:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAFD357A3D;
	Tue, 16 Dec 2025 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN6hg0GF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8EF357A5B
	for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894119; cv=none; b=OzBIuHjs/ob8qKQRpppuiEPxoKOvA+M7AT9wUsXAcDlCJuqhddPLj/0NUTafFgARwj7LCUtGbP/SJYsXDxLkaGeXv9CeLDq1Scwwt5+NCykE6C2xYOfCgKan5umradxjDUiuAyQPzOvoYsqrzjswPhba3m6Lodq6CrULTWpjlfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894119; c=relaxed/simple;
	bh=9rFMb124gT4wX6Z1BaKIkp+YpYgVU36olQWt2ZjruHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0Mbw/SBxEbhTAsE9MIS5eszAn6f5K9YWn8clHW7k+PRjjfH00kdYWMj4V3hPI/jtROTKDq9C4kww3YUbzfHPr7gSaACcRaik6t7pe9+IsvTZsX7hrfcPwwdYLewCdjeRs0kPbP0m63X+uK2CBzpvzDKtRgc8m+xR62p78ZfGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PN6hg0GF; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ae29ddaed9so2311033eec.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 06:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765894115; x=1766498915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ABDSVD0OZRkLhpM7GVbSEPZkovu4lepBLS40gdoYZS4=;
        b=PN6hg0GF0Vh9XdQq5NbCEnBauF6sAAYAJvfTlSZFQhpkNT5P8RkZBXPEQBaGDqyvt7
         doizhy47iicLf67qB6v9cve3ilnhwc5x4kzWbvXOhQqUYcxV3gvr0xdo2Heq/9ejWdtC
         v6amuJopjlUXmfpDcwAgmw9cgKi3/MqO4CpJhDohj0ihUyHJTPQYItjPlvPCOXFbZKtE
         djs4LNEyZO47aQRP7GMx4NVLmbN2/qdhLtWcpnWFAcJH/OO4u0DisqZZf7Rsk+qH5r1b
         5gtNiEbQF8P5QN5GAarDhnVfdsz/KHJx5Bm3E1r+ALXEsIosyHhkS9DACzMiCbiBprXh
         d58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765894115; x=1766498915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABDSVD0OZRkLhpM7GVbSEPZkovu4lepBLS40gdoYZS4=;
        b=dX6mHd+K/tH31zvClw0hifoddkJb4buIB6786AgHtbWW9IDw7UbsSGgZVU9XUX404K
         xBqGOhFDRnJpU35TEBd3F5Cjms+1BJdg8NtrQBeXbJZRkWYGXC1zNtC/PLvSRsnuou+D
         M1ZhNiZA612T8BfkaTf+BLgpffwk2DdzbYFcOZsMMV9QnfnnMOP4w11UlaSvSspK/9+5
         sbJGT6bGrEJPAt9yefRsNKfwYfZMiiuFUvMzHI0S1zBz2krHhZVcXZFpHjMIPJSF0GdV
         B1Lmd+Lw7ujLI3TAvy3aM3X0mSGiWe7xeChoo0Tg6EVb7ujKXpw6ohu06Sayc/tKgYdp
         3T7A==
X-Forwarded-Encrypted: i=1; AJvYcCXLtmIenIH6CfPtVmtZB8j8215+iZbuABxV1v1Yp3TPosK9q3Kgr9d98LPYmZJQ/vxN0kX3Syj8ku8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqeLw92ivgQqMAjByEpu6DUdvnmjvrSQEBU4BEeeT2wlSv5h/I
	OOTudVQHRoLAr+AV7F05W7H37gTurMPX7ktA58IKIrFC6lN92q+fc1zv
X-Gm-Gg: AY/fxX7i4e3BBEKZiTSCajwFcH93U6FvNGxixKk1CEK1O81+L/7Q+4rIhgGK9Y6CMX/
	bs54LU68cX0zs+XaOswwBm42kKQxZyum5TTn7G9uYES0EUi4B+LR9bIO4sbNUrOhbECYa0BxU7T
	hJ1TLLOhSM0mJz+oYHiXu015W8KMCpqK6xIYJz4j9A4ZVkKkv3pK2IbB5sNGufBHFshz7nDTL0m
	3p1LmQ9VJ3kF5qcoUi8bwopG7k7mruNuBYhZz/3gSA1mQQ+sNmt7qG+1epywg/VScuVBhm/CBxa
	er+YdUNq9kmDKl8BAvE6G3FS6Vkgx89US1NqGz837sdtDdEWWFigFEQAo5HNUM8NZvxn06dE7e6
	ZXe5257W0fIHgBcYpS2SmWbSNlAvdJ+GodutCLMqfnw5am7iNdS7nkk36umKghpycdBobGeDaR7
	YLArGZWnLBDBIYhXLcbF4=
X-Google-Smtp-Source: AGHT+IHut++cYKFHRhXb1H/jKXX0lEIBo0qPaxV41c3ukUPyZmolgjjJxKIEBV8l7YzJaRod0zxYeQ==
X-Received: by 2002:a05:7301:92c:b0:2a4:50c2:a74c with SMTP id 5a478bee46e88-2ac1c5e0f00mr8160301eec.8.1765894115073;
        Tue, 16 Dec 2025 06:08:35 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2ac190acd01sm39890645eec.1.2025.12.16.06.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:08:34 -0800 (PST)
Date: Tue, 16 Dec 2025 11:10:13 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 3/3] dt-bindings: iio: add analog devices
 ad9832/ad9835
Message-ID: <aUFoRVjoB7BHPTRN@debian-BULLSEYE-live-builder-AMD64>
References: <20251205202743.10530-1-tomasborquez13@gmail.com>
 <20251205202743.10530-4-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205202743.10530-4-tomasborquez13@gmail.com>

Hi Tomas,

Overall, the dt doc looks good to me.
In addition to comments from other reviewers, I have one suggestion related to
the SPI mode.

On 12/05, Tomas Borquez wrote:
> Add devicetree binding documentation for the AD9832 and AD9835
> Digital Synthesizer chips.
> 
> Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
> ---
>  .../bindings/iio/frequency/adi,ad9832.yaml    | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,ad9832.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,ad9832.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,ad9832.yaml
> new file mode 100644
> index 0000000000..f14e054ab2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,ad9832.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,ad9832.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD9832/AD9835 Direct Digital Synthesizer
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad9832
> +      - adi,ad9835
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: mclk
> +
> +  avdd-supply:
> +    description: Analog power supply.
> +
> +  dvdd-supply:
> +    description: Digital power supply.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - avdd-supply
> +  - dvdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
Specify that the device operates either in SPI mode 1 or SPI mode 2.
See [1, 2, 3] for reference.
  - oneOf:
      - required: [spi-cpha]
        properties:
          spi-cpol: false
      - required: [spi-cpol]
        properties:
          spi-cpha: false

[1]: https://www.analog.com/en/resources/app-notes/an-1248.html
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/spi/spi-summary.rst?h=v6.19-rc1
[3]: https://youtu.be/MV8Sy6jGUIE?t=611

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dds@0 {
> +            compatible = "adi,ad9832";
> +            reg = <0>;
> +            spi-max-frequency = <20000000>;

            spi-cpha;

> +            clocks = <&dds_clk>;
> +            clock-names = "mclk";
> +            avdd-supply = <&avdd_reg>;
> +            dvdd-supply = <&dvdd_reg>;
> +        };
> +    };
> +...
> -- 
> 2.43.0
> 
> 

