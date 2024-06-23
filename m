Return-Path: <linux-iio+bounces-6743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA172913993
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 12:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB94C1C214D6
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC7C12D760;
	Sun, 23 Jun 2024 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9LOCJSr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7A33EA69;
	Sun, 23 Jun 2024 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719138850; cv=none; b=U3Tn7Sl7kjx8mn+mzeInPmqYFTHyJxHphOEXxM/r+SQoRdJrxvhIKqeuC2DVK1Edbd2MYF9Jn7CCtgtE+PpRojXAeaQW5uH/JiXCKyRqJHNtdUGtQVO+LjtPpCeC1rE/i5KWoHAuys52rL9lHUXaO9ZE53ChzVZox4JC+MIIAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719138850; c=relaxed/simple;
	bh=WMDfPBqv8mCqyLWf4aN45hzN/sTkaqumDzdg1ZFXJhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYfvGaxwafRbw4TXjLMxCzq5z11lLTk0A66Zjue250wrkwwgWU7e2tH/xzBoB9nz5aBhzOwDzSsJlujvXJDH+MA433gtjMj5iYuACMDhY80Y1f65ILeuXlk0IdvxAH9XTN742+JKRJtP38n6Rv7gOIkqS2b8LYu9veRjJ995SLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9LOCJSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7208FC2BD10;
	Sun, 23 Jun 2024 10:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719138849;
	bh=WMDfPBqv8mCqyLWf4aN45hzN/sTkaqumDzdg1ZFXJhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B9LOCJSrdS9WbCc2qReyLJXgIezc9p3zujoEjhIsm9a4z/MUbQG+4GJxC+ngwJ+8p
	 fi8xzxsdm1Mc1QcRy6VeyIx1giM30gAE8V/yRrnYCO9Qf0I4pIdybeWoWLKyl61Ru2
	 4Qh4aAYRiSn7loy5ZW/9kM8Avux3U3LuE2+VVLJxEnUD6f8syDpePcw9Dn0FFVvU1o
	 2jn3RY82T/fVwHJz4e8vOXig4i+C2KrDK92AjgjzI33RrF91nRQgEmHLdRmxldw7j5
	 tow8+XDmAhxRXB3UzG+g/YMzCeBuJ6NDFw9VWQ1+lXNTVFtMa8nxE43++EEtUemwZO
	 BplUhPPgn7ctA==
Date: Sun, 23 Jun 2024 11:34:00 +0100
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
Subject: Re: [PATCH v2 3/3] docs: iio: add documentation for adxl380 driver
Message-ID: <20240623113400.5dcc1d0d@jic23-huawei>
In-Reply-To: <20240621101756.27218-3-antoniu.miclaus@analog.com>
References: <20240621101756.27218-1-antoniu.miclaus@analog.com>
	<20240621101756.27218-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 13:17:05 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add documentation for adxl380 driver which describes the driver
> device files and shows how the user may use the ABI for various
> scenarios (configuration, measurement, etc.).
> 
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Looks good. Only comment is to make sure you run a docs build test.
We had one similar hexdump case blow up a few weeks back.

If you already have, just stick a note under the --- in the next version.
Everyone hates building the docs because it's slow so I know I sometimes
forget to do so and suspect others do as well!

> +Obtain buffered data:
> +
> +.. code-block:: bash
We recently got bitten by a processing issue for one of these hex dumps and changed it
to unformatted text.  Make sure you do an HTML docs build for this and check there
are no similar warnings (honestly I never really understood what was going wrong with the
parser).

If you do need unformatted text

Obtain buffered data::

plus the indent works. 

> +
> +        root:/sys/bus/iio/devices/iio:device0> hexdump -C /dev/iio\:device0
> +        ...
> +        002bc300  f7 e7 00 a8 fb c5 24 80  f7 e7 01 04 fb d6 24 80  |......$.......$.|

> +        002bc310  f7 f9 00 ab fb dc 24 80  f7 c3 00 b8 fb e2 24 80  |......$.......$.|
> +        002bc320  f7 fb 00 bb fb d1 24 80  f7 b1 00 5f fb d1 24 80  |......$...._..$.|
> +        002bc330  f7 c4 00 c6 fb a6 24 80  f7 a6 00 68 fb f1 24 80  |......$....h..$.|
> +        002bc340  f7 b8 00 a3 fb e7 24 80  f7 9a 00 b1 fb af 24 80  |......$.......$.|
> +        002bc350  f7 b1 00 67 fb ee 24 80  f7 96 00 be fb 92 24 80  |...g..$.......$.|
> +        002bc360  f7 ab 00 7a fc 1b 24 80  f7 b6 00 ae fb 76 24 80  |...z..$......v$.|
> +        002bc370  f7 ce 00 a3 fc 02 24 80  f7 c0 00 be fb 8b 24 80  |......$.......$.|
> +        002bc380  f7 c3 00 93 fb d0 24 80  f7 ce 00 d8 fb c8 24 80  |......$.......$.|
> +        002bc390  f7 bd 00 c0 fb 82 24 80  f8 00 00 e8 fb db 24 80  |......$.......$.|
> +        002bc3a0  f7 d8 00 d3 fb b4 24 80  f8 0b 00 e5 fb c3 24 80  |......$.......$.|
> +        002bc3b0  f7 eb 00 c8 fb 92 24 80  f7 e7 00 ea fb cb 24 80  |......$.......$.|
> +        002bc3c0  f7 fd 00 cb fb 94 24 80  f7 e3 00 f2 fb b8 24 80  |......$.......$.|
> +        ...

