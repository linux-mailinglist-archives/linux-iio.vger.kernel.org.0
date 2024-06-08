Return-Path: <linux-iio+bounces-6048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0429011BD
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 15:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613261F21FE6
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 13:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33E1179972;
	Sat,  8 Jun 2024 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sx6IPojJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B7BE57D;
	Sat,  8 Jun 2024 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717854288; cv=none; b=RrVzRX9STSKTKICGkmNF+C4sMjLcPXiLzdN0hAiCa0DWnrh1+V8NdXguYS4vreRw8gRGrUgPxvzgiar20pG7suFksbwWKbDcAEKr/JA33CDNo2VrnOTAHN/EVlZc/ZbiKdbVfMl3G/deYgKV4NFGri43ndgJzZXN+YYoZ/4lpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717854288; c=relaxed/simple;
	bh=u+65EOg95RMG8+T/dZJMqWa8Q0VgKMhpOjWei+5HBZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ku7CSO/jUKTGYxJpON+vQD7DccbKUjG7EDw8k8AvWHCrO0XED2SXr85Hv0/ajtJt212IRXBg8don6ZCY7CvH3ee2m99uU+9jG5AfkjtetvigvWm3oKR7WJ5eTU7JfFHuAMDhhTO6pZOwUamBDCqgzrMnI3O86bZnFRh1DoL+dEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sx6IPojJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19676C2BD11;
	Sat,  8 Jun 2024 13:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717854288;
	bh=u+65EOg95RMG8+T/dZJMqWa8Q0VgKMhpOjWei+5HBZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sx6IPojJWoJf8REA79Y8x1+xWnkbHpYIiF3LkPEX5kOfst/F5URLZKKN1qo3gjDLN
	 hf7ckuKOVZ70M5a8WOcFsbzVaTLXAhYkmqjjq8isnEoMoC8UaO+jq/lw0fn7TjIY3x
	 oJlsMLf8dBNyUcjuK9HyNguTSgSCJBRCn9aDekvUfbTSialsSQEcBwEu4QtS4YTlqV
	 /YaZPIKzchX4rjIVWGMqEtw0eVb7mUYM2Fs9dkRyCqW+bM2+fOnfQYZnqLCn8qhrar
	 aHdAxoGLpQmOqa/DQb/vTm9vZQPi7BPcLkvpU42Gu0zy4kOlh3uX6RiVx5NmXBbANA
	 qbu4ZlIWe7yOA==
Date: Sat, 8 Jun 2024 14:44:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, corbet@lwn.net,
 conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
 Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: Re: [PATCH v2 6/6] docs: iio: add documentation for adis16480
 driver
Message-ID: <20240608144439.06889236@jic23-huawei>
In-Reply-To: <20240528142409.239187-7-ramona.gradinariu@analog.com>
References: <20240528142409.239187-1-ramona.gradinariu@analog.com>
	<20240528142409.239187-7-ramona.gradinariu@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 17:24:09 +0300
Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:

> Add documentation for adis16480 driver which describes the driver
> device files and shows how the user may use the ABI for various
> scenarios (configuration, measurement, etc.).
> 
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>

> +Obtain buffered data:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> hexdump -C /dev/iio\:device0
> +        ...
> +        00006aa0  09 62 00 00 ff ff fc a4  00 00 01 69 00 03 3c 08  |.b.........i..<.|
> +        00006ab0  09 61 00 00 00 00 02 96  00 00 02 8f 00 03 37 50  |.a............7P|
> +        00006ac0  09 61 00 00 00 00 12 3d  00 00 0b 89 00 03 2c 0b  |.a.....=......,.|
> +        00006ad0  09 61 00 00 00 00 1e dc  00 00 16 dd 00 03 25 bf  |.a............%.|
> +        00006ae0  09 61 00 00 00 00 1e e3  00 00 1b bf 00 03 27 0b  |.a............'.|
> +        00006af0  09 61 00 00 00 00 15 50  00 00 19 44 00 03 30 fd  |.a.....P...D..0.|
> +        00006b00  09 61 00 00 00 00 09 0e  00 00 14 41 00 03 3d 7f  |.a.........A..=.|
> +        00006b10  09 61 00 00 ff ff ff f0  00 00 0e bc 00 03 48 d0  |.a............H.|
> +        00006b20  09 63 00 00 00 00 00 9f  00 00 0f 37 00 03 4c fe  |.c.........7..L.|
> +        00006b30  09 64 00 00 00 00 0b f6  00 00 18 92 00 03 43 22  |.d............C"|
> +        00006b40  09 64 00 00 00 00 18 df  00 00 22 33 00 03 33 ab  |.d........"3..3.|
> +        00006b50  09 63 00 00 00 00 1e 81  00 00 26 be 00 03 29 60  |.c........&...)`|
> +        00006b60  09 63 00 00 00 00 1b 13  00 00 22 2f 00 03 23 91  |.c........"/..#.|
> +        ...
This is tripping up the docs builds on 0-day.
I'm not going to figure out why, so for now I've just made this an unformatted text block
via :: and an indent.

Documentation/iio/adis16480.rst:419: WARNING: Lexing literal_block 'root:/sys/bus/iio/devices/iio:device0> hexdump -C /dev/iio\\:device0\n...\n00006aa0  09 62 00 00 ff ff fc a4  00 00 01 69 00 03 3c 08  |.b.........i..<.|\n00006ab0  09 61 00 00 00 00 02 96  00 00 02 8f 00 03 37 50  |.a............7P|\n00006ac0  09 61 00 00 00 00 12 3d  00 00 0b 89 00 03 2c 0b  |.a.....=......,.|\n00006ad0  09 61 00 00 00 00 1e dc  00 00 16 dd 00 03 25 bf  |.a............%.|\n00006ae0  09 61 00 00 00 00 1e e3  00 00 1b bf 00 03 27 0b  |.a............\'.|\n00006af0  09 61 00 00 00 00 15 50  00 00 19 44 00 03 30 fd  |.a.....P...D..0.|\n00006b00  09 61 00 00 00 00 09 0e  00 00 14 41 00 03 3d 7f  |.a.........A..=.|\n00006b10  09 61 00 00 ff ff ff f0  00 00 0e bc 00 03 48 d0  |.a............H.|\n00006b20  09 63 00 00 00 00 00 9f  00 00 0f 37 00 03 4c fe  |.c.........7..L.|\n00006b30  09 64 00 00 00 00 0b f6  00 00 18 92 00 03 43 22  |.d............C"|\n00006b40  09 64 00 00 00 00 18 df  00 00 22 33 00 03 3
 3 ab  |.d........"3..3.|\n00006b50  09 63 00 00 00 00 1e 81  00 00 26 be 00 03 29 60  |.c........&...)`|\n00006b60  09 63 00 00 00 00 1b 13  00 00 22 2f 00 03 23 91  |.c........"/..#.|\n...' as "bash" resulted in an error at token: "'". Retrying in relaxed mode.

Introduced by commit

  d6de8052f4a0 ("docs: iio: add documentation for adis16480 driver")

> +
> +See ``Documentation/iio/iio_devbuf.rst`` for more information about how buffered
> +data is structured.
> +
> +4. IIO Interfacing Tools
> +========================
> +
> +See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
> +interfacing tools.
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index 66fa69102e3a..4c13bfa2865c 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -19,5 +19,6 @@ Industrial I/O Kernel Drivers
> 
>     ad7944
>     adis16475
> +   adis16480
>     bno055
>     ep93xx_adc
> --
> 2.34.1
> 


