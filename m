Return-Path: <linux-iio+bounces-17307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFD7A745D5
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 09:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C727A7130
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 08:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C90E2135C3;
	Fri, 28 Mar 2025 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqZ8b8Ox"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2630C213255;
	Fri, 28 Mar 2025 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743152297; cv=none; b=RQbRcikppCQxRJ7e7nLXALlDaf2NxBLEA3ZTnLjY4ewvDaDKlTMhwjRkAANV7MSCK5n8rhDbwb97Vr8xEqmiZLFi8hYvfrEvT/cSAOuOLl6FNYXlrtfbD0dKLgqXZxvragU41VH2HJHX/HrfazsgcKsy8OfJlNex03eL+OkyM/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743152297; c=relaxed/simple;
	bh=iG2vQX9C9wvH1r4TQLc3s9WUefTjRwU/KWarh7bNpaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERlnBp0zm9xfTGobLUbVI8ar6att2OhYxb2T8qizYigYUvx4v+8hIQXl+aG2Z/l2+o8VcKbjmvqlKxYuZ4n3AydpKMugrFu5iwAga5SbbOiG9YulRP8Ht8Gy02JuDMnIUHffWd/JvF5IjcnRFWKspSQ5pcYFIwZHeB09NXbX8a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqZ8b8Ox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D869C4CEE4;
	Fri, 28 Mar 2025 08:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743152296;
	bh=iG2vQX9C9wvH1r4TQLc3s9WUefTjRwU/KWarh7bNpaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QqZ8b8OxhMkKPGJYVT3jTlU0Y6kwOa3pDiGB0hhZ7KDzJg7Q5tukQ0ZHW0XlGpgq7
	 hYu9kyftSQytjOy6wDDv2xDA0blQwdpSxNY9ShnhpELtSXOomlNeh5BJvQFJYBpiad
	 cPg2CrP6R8n5Wwm/BDU5S5IVCCwRxlFwvccCejRke8/EPo8vCvwVwgnbKSf/f0P1AT
	 0k4WE61puykFACM/TYbYOk3VAmmTfPz1K6GmmG5sOugtItf5KrWIfQHrPRClJ1d1CE
	 lOCsKWFOU/TwK+ja+imkcz7AR5nqbPLTXljv6YOw4l8dqhw2fq0Q7zEHtChxX7sgUL
	 JMppIe29k8GNA==
Date: Fri, 28 Mar 2025 08:58:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] iio: dac: ad3530r: Add ABI file for the AD3530R
 DAC
Message-ID: <20250328085805.44122c63@jic23-huawei>
In-Reply-To: <20250324-togreg-v2-2-f211d781923e@analog.com>
References: <20250324-togreg-v2-0-f211d781923e@analog.com>
	<20250324-togreg-v2-2-f211d781923e@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Mar 2025 19:22:56 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> Define muxout_select and muxout_select_available sysfs interface for the
> AD3530R and AD3531R DAC.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-dac-ad3530r          | 68 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  7 +++
>  2 files changed, 75 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ad3530r b/Docume=
ntation/ABI/testing/sysfs-bus-iio-dac-ad3530r
> new file mode 100644
> index 0000000000000000000000000000000000000000..9d3126952fd1c5214afb895c4=
972dc4a891ed7d4
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad3530r
> @@ -0,0 +1,68 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/muxout_select
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Selects which of the multiplexer's input signals will be
> +		monitored on the MUX_OUT pin.
Hi Kim,

Do we have a use case where the monitoring would not be by an ADC attached
to the host CPU? (i.e. using a channel on an ADC that has it's own IIO driv=
er)

If no other use case, then support this as a consumer of an ADC channel from
another device with all these exposed as different channels when a read is =
requested.
There are quite a few drivers doing this already.

The source vs sink thing may need to be done via labels as it isn't a conce=
pt
that maps directly to ADC channel characteristics.

If this is being routed to some external hardware monitoring then most like
this should be in device tree as doesn't make sense to switch dynamically in
any cases that I recall from previous similar drivers.

Jonathan

> +		* powered_down - MUX_OUT pin is powered down. An 80k=CE=A9 impedance
> +				 can be seen at the MUX_OUT pin.
> +		* vout0 - Voltage representation of VOUT0.
> +		* iout0_source - Voltage representation of IOUT0 (source mode).
> +		* iout0_sink - Voltage representation of IOUT0 (sink mode).
> +		* vout1 - Voltage representation of VOUT1.
> +		* iout1_source - Voltage representation of IOUT1 (source mode).
> +		* iout1_sink - Voltage representation of IOUT1 (sink mode).
> +		* vout2 - Voltage representation of VOUT2.
> +		* iout2_source - Voltage representation of IOUT2 (source mode).
> +		* iout2_sink - Voltage representation of IOUT2 (sink mode).
> +		* vout3 - Voltage representation of VOUT3
> +		* iout3_source - Voltage representation of IOUT3 (source mode).
> +		* iout3_sink - Voltage representation of IOUT3 (sink mode).
> +		* vout4 - Voltage representation of VOUT4.
> +		* iout4_source - Voltage representation of IOUT4 (source mode).
> +		* iout4_sink - Voltage representation of IOUT4 (sink mode).
> +		* vout5 - Voltage representation of VOUT5.
> +		* iout5_source - Voltage representation of IOUT5 (source mode).
> +		* iout5_sink - Voltage representation of IOUT5 (sink mode).
> +		* vout6 - Voltage representation of VOUT6.
> +		* iout6_source - Voltage representation of IOUT6 (source mode).
> +		* iout6_sink - Voltage representation of IOUT6 (sink mode).
> +		* vout7 - Voltage representation of VOUT7.
> +		* iout7_source - Voltage representation of IOUT7 (source mode).
> +		* iout7_sink - Voltage representation of IOUT7 (sink mode).
> +		* die_temp - Voltage representation of internal die temperature.
> +		* agnd - MUX_OUT pin internally tied to AGND.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/muxout_select_available
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading this returns the valid values that can be written to the
> +		muxout_select attribute:
> +		* powered_down
> +		* vout0
> +		* iout0_source
> +		* iout0_sink
> +		* vout1
> +		* iout1_source
> +		* iout1_sink
> +		* vout2
> +		* iout2_source
> +		* iout2_sink
> +		* vout3
> +		* iout3_source
> +		* iout3_sink
> +		* vout4
> +		* iout4_source
> +		* iout4_sink
> +		* vout5
> +		* iout5_source
> +		* iout5_sink
> +		* vout6
> +		* iout6_source
> +		* iout6_sink
> +		* vout7
> +		* iout7_source
> +		* iout7_sink
> +		* die_temp
> +		* agnd
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ffdb3f21fc4fb35b349449afbb30fecd4fe72978..2d3c31c74594ca1934c67e7aa=
d0a179feeaa39bf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1289,6 +1289,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/g=
it/netdev/net.git
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
>  F:	drivers/net/amt.c
> =20
> +ANALOG DEVICES INC AD3530R DRIVER
> +M:	Kim Seer Paller <kimseer.paller@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ad3530r
> +
>  ANALOG DEVICES INC AD3552R DRIVER
>  M:	Nuno S=C3=A1 <nuno.sa@analog.com>
>  L:	linux-iio@vger.kernel.org
>=20


