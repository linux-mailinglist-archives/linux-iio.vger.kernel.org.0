Return-Path: <linux-iio+bounces-25792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB66C28DAE
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 11:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CC53A3CCE
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 10:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBD12609FC;
	Sun,  2 Nov 2025 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3Jys8vA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DDA1F03D7;
	Sun,  2 Nov 2025 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762081022; cv=none; b=OSsMuh1O9aO0t8XWhFVAEU0dOTrh3Wi8bsyqE3B9lLk5pHqvpx6pPwGJGHnEZkgMq8mhCOCaJ/Z1/IPW5hFGkDzTB5oxs/at+BOkYRe2GG5DEEuB5k5OH0Sj/qzXZtE2wpS+qKDuuJIvwK3Ilvb6CYLhdIN7hhTahyHgjPeR8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762081022; c=relaxed/simple;
	bh=VETvWM9sV4Inw4AwNYnPAuJaCEgDO8N9qrqjhHB+EJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uo2AAO85zMixT0ZzGRSGLjjzmHlzlza6k2Wh8cFRNvu/9m3lvQBgQgvatxUAWS7lbciPXpbyV/F1c3iKrEmJHiy74m1xbujt6NjOahbSIjJX5xuffZ0JR0wj9unMWJ9WB2X4UT/pe7KtLAqH2a1Ovv5FL/iqbXKPwbmw20BUeas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3Jys8vA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6B1C4CEF7;
	Sun,  2 Nov 2025 10:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762081021;
	bh=VETvWM9sV4Inw4AwNYnPAuJaCEgDO8N9qrqjhHB+EJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P3Jys8vAOaOFcymhw/zjhdD3qCRFUeoioz3y+N8oVQ5KDOKm+6E60DkpG9fOCCD7c
	 fvCqyX9YA75b5kiaLX2tV9bm+ci9UnuCs2IvNHHrQqZTAGQrV2pEHGmj+IybiO8ore
	 dU7P3zOFJV1a+x2PcWpReHXcMnWDAAe8w0IS+OT62N1NsXuheLJHvRsRtacCSUMBGg
	 wTWF/fOMsd0ezB4gZti57FFSXpXlLIYUiq790SiwwgshcPdKzinyVDkrv+9j/BPL3Y
	 27lVv9lMCSs/rLh/MyF/kHgWUtgp2wgQPTJ4CsFaCksClpFRoTOIMjNDDHksy104AZ
	 rwPSu2SERmgAQ==
Date: Sun, 2 Nov 2025 10:56:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] Documentation: ABI: adl8113: add documentation
Message-ID: <20251102105633.3036186f@jic23-huawei>
In-Reply-To: <20251031160405.13286-4-antoniu.miclaus@analog.com>
References: <20251031160405.13286-1-antoniu.miclaus@analog.com>
	<20251031160405.13286-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 16:04:05 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add ABI documentation for the ADL8113 Low Noise Amplifier,
> covering the 4 pin-selectable operating modes.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../testing/sysfs-bus-iio-amplifiers-adl8113  | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113 b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
> new file mode 100644
> index 000000000000..6155b79e6b83
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
> @@ -0,0 +1,32 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/mode
> +Date:		January 2025
> +KernelVersion:	6.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute allows the user to set the operation mode of the
> +		ADL8113 Low Noise Amplifier. The available modes control signal
> +		routing through different paths within the device.
> +
> +		The supported modes are:
> +
> +		* internal_amplifier - Signal passes through the internal low
> +		  noise amplifier (VA=0, VB=0). Provides 14dB gain.
> +
> +		* internal_bypass - Signal bypasses through internal bypass path
> +		  (VA=1, VB=1). Provides 0dB gain.

These first would map fine to standard ABI for gain control I think.
I'd prefer to see that used if possible than invention of new ABI for that.

> +
> +		* external_bypass_a - Signal routes through external bypass path A
> +		  (VA=0, VB=1). Provides 0dB gain.

Problem with this an next one as I mention in binding is we have no idea what
is between those two external pins so no way to present a generic userspace interface.

Any idea if there is anything that is standard to wire in there?  I could see for instance
nesting a similar amplifier to this one with different gain.  Maybe we should have
a go at describing that.  This device would be a consumer of channels provided by
another etc.

> +
> +		* external_bypass_b - Signal routes through external bypass path B
> +		  (VA=1, VB=0). Provides 0dB gain.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/mode_available
> +Date:		January 2025
> +KernelVersion:	6.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading this attribute returns a space-separated list of all
> +		available operation modes for the ADL8113 device. The modes
> +		control the signal path and determine whether the signal passes
> +		through the internal amplifier or various bypass paths.


