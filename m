Return-Path: <linux-iio+bounces-676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F188076CB
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 18:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F68B20E4F
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD73D6AB82;
	Wed,  6 Dec 2023 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiKEqaut"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA7A6A00A;
	Wed,  6 Dec 2023 17:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA17C433C7;
	Wed,  6 Dec 2023 17:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701884460;
	bh=ha/WzCOsQe3G+coUldXRa0OE2YfkZhh+fxESdFI6heA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XiKEqautHbq72b4VhUNaN3Y1psiZAOIoJu8izwzTVqxMfHFSTWaXqr5NItM69xil8
	 02YlOLBg0kwJk73sZN2J1S43UT9rV39PbQ+VPW05ojhS1GNfcNR6zmgJqzWfsMdwIj
	 WZbYgLsy6L3gIHh7cLChLV8RGNSJcuS9U7xfwLKi1c9kqrnKHz3AU2GpX/8aUtcrri
	 +3ZaaMfd5aEJZggjz/joKAb0o5wkokWmesjhyWRVU5cgDSOpouma7O5qC21DPTX+KU
	 g9CyCAWyHtk/rxAHzFX+ID4rUC3AM2gxWRbIyZQFhtWgPLKAjRA5Sb15Kkar05ssLP
	 XABqbLzga30hA==
Date: Wed, 6 Dec 2023 17:40:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
 robh+dt@kernel.org, lars@metafoo.de, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: Add AMS AS6200
Message-ID: <20231206174050.12ad1c98@jic23-huawei>
In-Reply-To: <ZW6IqoelmMhTgjgW@abdel>
References: <20231202041651.719963-1-alkuor@gmail.com>
	<20231203-wrecking-sneer-d34f19c39f04@spud>
	<ZW6IqoelmMhTgjgW@abdel>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Dec 2023 21:19:22 -0500
Abdel Alkuor <alkuor@gmail.com> wrote:

> On Sun, Dec 03, 2023 at 11:24:31AM +0000, Conor Dooley wrote:
> > On Fri, Dec 01, 2023 at 11:16:50PM -0500, Abdel Alkuor wrote:  
> > > as6200 is high accuracy temperature sensor of -/+ 0.4C degree  
> >  
> Hi Conor,
> > Is +/- 0.4 degrees really "high accuracy"?
> >  
> That's what the datasheet says :D. I'll remove it.

I'd not noticed this.  Why is this an IIO driver rather than an hwmon one?

Mostly we do that only for very high accuracy or weird temperature sensors
(infrared ones for example or things with complex thermocouple handling).
Simpler devices meant for hardware monitoring type applications typically go
in hwmon.

We have the iio to hwmon bridge driver for things that naturally have uses
where IIO features are needed, but which get used for hwmon sometimes.
Not sure this is enough IIO focused though, so perhaps list out why you
think it should be in IIO?

Jonathan


