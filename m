Return-Path: <linux-iio+bounces-7047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0638A91CE57
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 19:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B615B21B9A
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 17:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0091B12FF86;
	Sat, 29 Jun 2024 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfUThVSH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50DF7E572;
	Sat, 29 Jun 2024 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719683079; cv=none; b=g5AWzeulTbsxJzYvGHza/tQl6vA/WedUioo4fcb6q5vPhDrmIZdKQAC3OvsAHcBpt1SDDPp8anIzJxlRztVgZmtWiHqCIThlRmhio9LWZhEVcid5bpufR/cBeR7/jczMosaCqZb0YrV9CbmJg7V4TVGrwq38JGRsQ0KMvm6ebIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719683079; c=relaxed/simple;
	bh=kQtXZ8r2t9qbT4QtqZSm4V7hQN1fsf2FPY2PAvWolpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qk84IUp5y5+E3Id1Q4vt6WoAM7NmE6+jx2F9y5+Z6GeKQZVsIza0XQIy+KYxbsZAbUzCuj6VA5CCyONpNjGDYp9nvo/+R9ZLod5eMy6dtLw2gUVO2eEVzQ511fTsK1CYEAKZqocF8XKdwBX/5SOjD0o1XVjXmBMiiRyQXT0ttrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfUThVSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A620C2BBFC;
	Sat, 29 Jun 2024 17:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719683079;
	bh=kQtXZ8r2t9qbT4QtqZSm4V7hQN1fsf2FPY2PAvWolpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MfUThVSHSdwoxWdZW6djfhWZ5ZOFGhDywF4Wc+Z97pjS3ZuVyeGG/jg/ARojxNIly
	 d+89hHOyHsTyU6qyQLzdl/AaE2N7qyKbh6bATwg0/c8neC+HzWLpCnLtS1TZ0G7iS1
	 0kxaUbiCvT1QU+6OpHGMN8gWYvfpu9VubswC8adGuHfjDnu592kUiWi97MqVcTt+zO
	 eFFulACIieB8USgnK/VtIlNbkPDXfaHrW55s/mhg9q8fxgi1WnxYfNF0Ck5AshQGH8
	 NTLR6vsmRyyuQGXNcmiwdlEJQjzQVUMmKzS6Da6TAwLwsJvkJ4umwkevJubXC7tZVi
	 RcYkTZPJJQhTA==
Date: Sat, 29 Jun 2024 18:44:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Michael Hennerich" <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jun Yan
 <jerrysteve1101@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Mehdi Djait
 <mehdi.djait.k@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] docs: iio: add documentation for adxl380 driver
Message-ID: <20240629184430.7d1fdd54@jic23-huawei>
In-Reply-To: <20240627102617.24416-3-antoniu.miclaus@analog.com>
References: <20240627102617.24416-1-antoniu.miclaus@analog.com>
	<20240627102617.24416-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Jun 2024 13:25:19 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add documentation for adxl380 driver which describes the driver
> device files and shows how the user may use the ABI for various
> scenarios (configuration, measurement, etc.).
>=20
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
>  - performed docs build via `make htmldocs` and no warnings were
>    detected for adxl380 documentation.=20
Great. I'm paranoid about this (and often forget to check myself!)

This looks good to me except as with the DT binding, I think you
want to tone down the marketting a little!

Thanks,

Jonathan

>  Documentation/iio/adxl380.rst | 238 ++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst   |   1 +
>  2 files changed, 239 insertions(+)
>  create mode 100644 Documentation/iio/adxl380.rst
>=20
> diff --git a/Documentation/iio/adxl380.rst b/Documentation/iio/adxl380.rst
> new file mode 100644
> index 000000000000..a64e330a18ee
> --- /dev/null
> +++ b/Documentation/iio/adxl380.rst
> @@ -0,0 +1,238 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ADXL380 driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This driver supports Analog Device's ADXL380/382 on SPI/I2C bus.
> +
> +1. Supported devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +* `ADXL380 <https://www.analog.com/ADXL380>`_
> +* `ADXL382 <https://www.analog.com/ADXL382>`_
> +
> +The ADXL380/ADXL382 is a low noise density, low power, 3-axis accelerome=
ter with
> +selectable measurement ranges. The ADXL380 supports the =C2=B14 g, =C2=
=B18 g, and =C2=B116 g
> +ranges, and the ADXL382 supports =C2=B115 g, =C2=B130 g, and =C2=B160 g =
ranges.
> +
> +The ADXL380/ADXL382 offers industry leading noise, enabling precision
> +applications with minimal calibration.=20
This bit is marketting heavy.

> The low noise, and low power
> +ADXL380/ADXL382 enables accurate measurement in an environment with high
> +vibration, heart sounds and audio.

This is more reasonable as talking about where it might be used.

> +
> +2. Device attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Accelerometer measurements are always provided.
> +
> +Temperature data are also provided. This data can be used to monitor the
> +internal system temperature or to improve the temperature stability of t=
he
> +device via calibration.
> +
> +Each IIO device, has a device folder under ``/sys/bus/iio/devices/iio:de=
viceX``,
> +where X is the IIO index of the device. Under these folders reside a set=
 of
> +device files, depending on the characteristics and features of the hardw=
are
> +device in questions. These files are consistently generalized and docume=
nted in
> +the IIO ABI documentation.
> +
> +The following tables show the adxl380 related device files, found in the
> +specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
> +
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| 3-Axis Accelerometer related device files         | Description       =
                                       |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_accel_scale                                    | Scale for the acce=
lerometer channels.                    |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_accel_filter_high_pass_3db_frequency           | Low pass filter ba=
ndwidth.                               |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_accel_filter_high_pass_3db_frequency_available | Available low pass=
 filter bandwidth configurations.      |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_accel_filter_low_pass_3db_frequency            | High pass filter b=
andwidth.                              |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_accel_filter_low_pass_3db_frequency_available  | Available high pas=
s filter bandwidth configurations.     |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_accel_x_calibbias                              | Calibration offset=
 for the X-axis accelerometer channel. |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_accel_x_raw                                    | Raw X-axis acceler=
ometer channel value.                  |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_accel_y_calibbias                              | y-axis acceleratio=
n offset correction                    |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_accel_y_raw                                    | Raw Y-axis acceler=
ometer channel value.                  |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_accel_z_calibbias                              | Calibration offset=
 for the Z-axis accelerometer channel. |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_accel_z_raw                                    | Raw Z-axis acceler=
ometer channel value.                  |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +
> ++----------------------------------+------------------------------------=
--------+
> +| Temperature sensor related files | Description                        =
        |
> ++----------------------------------+------------------------------------=
--------+
> +| in_temp_raw                      | Raw temperature channel value.     =
        |
> ++----------------------------------+------------------------------------=
--------+
> +| in_temp_offset                   | Offset for the temperature sensor c=
hannel. |
> ++----------------------------------+------------------------------------=
--------+
> +| in_temp_scale                    | Scale for the temperature sensor ch=
annel.  |
> ++----------------------------------+------------------------------------=
--------+
> +
> ++------------------------------+----------------------------------------=
------+
> +| Miscellaneous device files   | Description                            =
      |
> ++------------------------------+----------------------------------------=
------+
> +| name                         | Name of the IIO device.                =
      |
> ++------------------------------+----------------------------------------=
------+
> +| sampling_frequency           | Currently selected sample rate.        =
      |
> ++------------------------------+----------------------------------------=
------+
> +| sampling_frequency_available | Available sampling frequency configurat=
ions. |
> ++------------------------------+----------------------------------------=
------+
> +
> +Channels processed values
> +-------------------------
> +
> +A channel value can be read from its _raw attribute. The value returned =
is the
> +raw value as reported by the devices. To get the processed value of the =
channel,
> +apply the following formula:
> +
> +.. code-block:: bash
> +
> +        processed value =3D (_raw + _offset) * _scale
> +
> +Where _offset and _scale are device attributes. If no _offset attribute =
is
> +present, simply assume its value is 0.
> +
> +The adis16475 driver offers data for 2 types of channels, the table belo=
w shows
> +the measurement units for the processed value, which are defined by the =
IIO
> +framework:
> +
> ++-------------------------------------+---------------------------+
> +| Channel type                        | Measurement unit          |
> ++-------------------------------------+---------------------------+
> +| Acceleration on X, Y, and Z axis    | Meters per Second squared |
> ++-------------------------------------+---------------------------+
> +| Temperature                         | Millidegrees Celsius      |
> ++-------------------------------------+---------------------------+
> +
> +Usage examples
> +--------------
> +
> +Show device name:
> +
> +.. code-block:: bash
> +
> +	root:/sys/bus/iio/devices/iio:device0> cat name
> +        adxl382
> +
> +Show accelerometer channels value:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_raw
> +        -1771
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_y_raw
> +        282
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_z_raw
> +        -1523
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_scale
> +        0.004903325
> +
> +- X-axis acceleration =3D in_accel_x_raw * in_accel_scale =3D =E2=88=928=
.683788575 m/s^2
> +- Y-axis acceleration =3D in_accel_y_raw * in_accel_scale =3D 1.38273765=
 m/s^2
> +- Z-axis acceleration =3D in_accel_z_raw * in_accel_scale =3D -7.4677639=
75 m/s^2
> +
> +Set calibration offset for accelerometer channels:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_calibbias
> +        0
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo 50 > in_accel_x_cali=
bbias
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_calibbias
> +        50
> +
> +Set sampling frequency:
> +
> +.. code-block:: bash
> +
> +	root:/sys/bus/iio/devices/iio:device0> cat sampling_frequency
> +        16000
> +        root:/sys/bus/iio/devices/iio:device0> cat sampling_frequency_av=
ailable
> +        16000 32000 64000
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo 32000 > sampling_fre=
quency
> +        root:/sys/bus/iio/devices/iio:device0> cat sampling_frequency
> +        32000
> +
> +Set low pass filter bandwidth for accelerometer channels:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_filter_low_p=
ass_3db_frequency
> +        32000
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_filter_low_p=
ass_3db_frequency_available
> +        32000 8000 4000 2000
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo 2000 > in_accel_filt=
er_low_pass_3db_frequency
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_filter_low_p=
ass_3db_frequency
> +        2000
> +
> +3. Device buffers
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This driver supports IIO buffers.
> +
> +All devices support retrieving the raw acceleration and temperature meas=
urements
> +using buffers.
> +
> +Usage examples
> +--------------
> +
> +Select channels for buffer read:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in=
_accel_x_en
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in=
_accel_y_en
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in=
_accel_z_en
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in=
_temp_en
> +
> +Set the number of samples to be stored in the buffer:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo 10 > buffer/length
> +
> +Enable buffer readings:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > buffer/enable
> +
> +Obtain buffered data:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> hexdump -C /dev/iio\:devi=
ce0
> +        ...
> +        002bc300  f7 e7 00 a8 fb c5 24 80  f7 e7 01 04 fb d6 24 80  |...=
...$.......$.|
> +        002bc310  f7 f9 00 ab fb dc 24 80  f7 c3 00 b8 fb e2 24 80  |...=
...$.......$.|
> +        002bc320  f7 fb 00 bb fb d1 24 80  f7 b1 00 5f fb d1 24 80  |...=
...$...._..$.|
> +        002bc330  f7 c4 00 c6 fb a6 24 80  f7 a6 00 68 fb f1 24 80  |...=
...$....h..$.|
> +        002bc340  f7 b8 00 a3 fb e7 24 80  f7 9a 00 b1 fb af 24 80  |...=
...$.......$.|
> +        002bc350  f7 b1 00 67 fb ee 24 80  f7 96 00 be fb 92 24 80  |...=
g..$.......$.|
> +        002bc360  f7 ab 00 7a fc 1b 24 80  f7 b6 00 ae fb 76 24 80  |...=
z..$......v$.|
> +        002bc370  f7 ce 00 a3 fc 02 24 80  f7 c0 00 be fb 8b 24 80  |...=
...$.......$.|
> +        002bc380  f7 c3 00 93 fb d0 24 80  f7 ce 00 d8 fb c8 24 80  |...=
...$.......$.|
> +        002bc390  f7 bd 00 c0 fb 82 24 80  f8 00 00 e8 fb db 24 80  |...=
...$.......$.|
> +        002bc3a0  f7 d8 00 d3 fb b4 24 80  f8 0b 00 e5 fb c3 24 80  |...=
...$.......$.|
> +        002bc3b0  f7 eb 00 c8 fb 92 24 80  f7 e7 00 ea fb cb 24 80  |...=
...$.......$.|
> +        002bc3c0  f7 fd 00 cb fb 94 24 80  f7 e3 00 f2 fb b8 24 80  |...=
...$.......$.|
> +        ...
> +
> +See ``Documentation/iio/iio_devbuf.rst`` for more information about how =
buffered
> +data is structured.
> +
> +4. IIO Interfacing Tools
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +See ``Documentation/iio/iio_tools.rst`` for the description of the avail=
able IIO
> +interfacing tools.
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index 4c13bfa2865c..1ce5b24d40aa 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -20,5 +20,6 @@ Industrial I/O Kernel Drivers
>     ad7944
>     adis16475
>     adis16480
> +   adxl380
>     bno055
>     ep93xx_adc


