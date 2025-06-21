Return-Path: <linux-iio+bounces-20815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9EEAE2A4E
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 18:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5283B65BE
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 16:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF1021CC43;
	Sat, 21 Jun 2025 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSZnu0gN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE0E30E859;
	Sat, 21 Jun 2025 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750523298; cv=none; b=bYXFOym3fw6/eCY7DcCSOZnLWsM4pdlEibu4DFFBpjbAUeCzCi8mRfNNQsEQPW3mW6FgDbbcfYamqre3hrXiDHomV0sbm9VEK3SkXMATF9Pr9A/oTHtIiwQvmZ2s7JAfiyZiw/UxphTaBUoPh0vj7q0dpRQ5ju+EinAiqG1ZgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750523298; c=relaxed/simple;
	bh=6TLyncxbiWa3QR4O3QZL40faVkmdmv9hfurNhPDlKI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+GiHnZMhnHJLH01e3xa+rjxqX6COGNBU2JnP/67TSqTWH3KvmBVgDaTa4Tnv8nf0VkOI+ZWzldhHF8ytY17wZo6xIk6dta3lvALfcbTSL98nVypWST8erbj26U1TKhNBYe9aghn1IEwQitrlR1nxJqurAmwGvGKa+9m1Rkub5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSZnu0gN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A38C4CEE7;
	Sat, 21 Jun 2025 16:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750523298;
	bh=6TLyncxbiWa3QR4O3QZL40faVkmdmv9hfurNhPDlKI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fSZnu0gNmiIiQoieyVjJpI2tN/8I+Ne1vrehIbv3wqpVI0h9dpgFkTpYY6bQM1drs
	 M2dX8Lct3XJngcX/CndTpHkIx21fg4NEpHKh/rpaC1mS6AXEA2JnNgNkFnfSGNyVSo
	 bhspClhqM4xi87BBLJnEi0JRw8tGNbPyoG4ALFDBmP+qPQGKOO/wcUyzdqwyNnCJ/a
	 3M7KkDomWJji06YPnvSb74H3r7LTuMEjGxjIcrHKQDUfofalpHoKgccXM0KUs+9hwb
	 eJjbh8db6ffDtkeldXh7T73UWkyNh9aT0fDkWBMEnhxDUZrWTC+vy0KGqigTWUorX+
	 iAqZ17CT7Smgw==
Date: Sat, 21 Jun 2025 17:28:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Conor Dooley <conor@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linus.walleij@linaro.org, brgl@bgdev.pl, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v5 01/11] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250621172808.6f304023@jic23-huawei>
In-Reply-To: <eeb66815-3f7d-41fc-9d32-c28a3dda7749@baylibre.com>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
	<4df9d4d0de83090300b6870afc8ae7b22279cd22.1749582679.git.marcelo.schmitt@analog.com>
	<20250616-neurology-explicit-ec2a829bd718@spud>
	<eeb66815-3f7d-41fc-9d32-c28a3dda7749@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >> +
> >> +$defs:
> >> +  reference-buffer:
> >> +    description: |
> >> +      Enable precharge buffer, full buffer, or skip reference buffering of
> >> +      the positive/negative voltage reference. Because the output impedance
> >> +      of the source driving the voltage reference inputs may be dynamic,
> >> +      resistive/capacitive combinations of those inputs can cause DC gain
> >> +      errors if the reference inputs go unbuffered into the ADC. Enable
> >> +      reference buffering if the provided reference source has dynamic high
> >> +      impedance output. Note the absolute voltage allowed on REFINn+ and REFINn-
> >> +      inputs is from AVSS - 50 mV to AVDD + 50 mV when the reference buffers are
> >> +      disabled but narrows to AVSS to AVDD when reference buffering is enabled
> >> +      or in precharge mode. The valid options for this property are:
> >> +      0: Reference precharge buffer.
> >> +      1: Full reference buffering.
> >> +      2: Bypass reference buffers (buffering disabled).
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    enum: [0, 1, 2]
> >> +    default: 1  
> > 
> > Why make this property a uint32, rather than a string where you can use
> > something like "precharge", "full" and "bypass" (or "disabled")? The
> > next similar device could use something slightly different then the
> > binding becomes pretty clunky.
> > Can you explain why this is a dt property rather than something
> > adjustable at runtime?
> > 
> > Otherwise, what you have here looks sane enough to me - but I'd like to
> > see some comments from Jonathan or David etc about your approach to the
> > excitation properties.  
> 
> This looks like something that should be in the devicetree to me. For example
> if the external reference supply is high impedance, buffering is pretty
> much required. And using precharge is an application design choice to
> reduce THD at the expense of other limitations.
> 

Agreed that this pretty much only makes sense in DT.

In the ideal world we would have firm rules on when to enable buffering
etc and then the DT would describe the impedance of the circuit connected
and any other relevant properties and then we'd have the driver enable it
only when those rigid rules dictated that we should.

Sadly no such simple rules exist (as far as I know) so we just expose the thing
that gets set dependent on someone's judgement of the suitability of
the buffering choice given the circuit being connected to the input.

If we pushed it to userspace we'd just end up with a per device blob
that dictated the mode to pick on boot and left it like that.  So effectively
another bit of firmware :(


J

<cropping other comments>

