Return-Path: <linux-iio+bounces-20631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C44D7AD9C54
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1822A3B9C90
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 11:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB6223D288;
	Sat, 14 Jun 2025 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhUaKTqO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8CC17FAC2;
	Sat, 14 Jun 2025 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749899094; cv=none; b=OytCc+uvrQsRKjQvHneildGi3nimWSQusnPlW+UKrT+uCX4ohCqhyOrPmsUZAgtvrDyg8dgnWCjiME3JysoXuhyBc+B9kVLLJfLZe/RHTscTV2ESQlenUdRD3Zy1Kmma3f2K5INl1uB2tMlREoZetJ9LS6tVMV0tm/lZ+j/026g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749899094; c=relaxed/simple;
	bh=tsR6Fvu5J9so0We0WNGg5pGWZK7NrjioKWeDajhlVkI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mb4ivKrYV5thLQZjyuOgwpBhIjRoWOozNm1bZokoPkQF/DNahRqohPf1eQcNOdo7XvfUDPgvmztJ9tH2tzpxvexaBxuRpZBpg5SBoB8PatrBd3SXn5y9lpS6Si0LmCBIJBHTfo3chyc/s+bxWiSvgUzjH21u0zH91kxPSIRYsxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhUaKTqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B396C4CEEB;
	Sat, 14 Jun 2025 11:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749899094;
	bh=tsR6Fvu5J9so0We0WNGg5pGWZK7NrjioKWeDajhlVkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QhUaKTqOrr1B6ihE7/tR7D5IvzOSiq3a19qzOX/MPipK4+79nTEp1BnRoS1sQW1jK
	 Al+I4VYhm6yyVQcWAYSvcWBlopENhFsxLTo7WQd80RfMyi0Ddn1ytMKBMzmYY2Pj20
	 ZYux36TBy+iR+4s1NcMazfESWdrIkNjbqdkm2l5LCmQbltAsG0ifDw6zZsawa5VMh2
	 iH8HdwnFHP8Jc0UVjkYH/DfhEsDDuZE+3lWxgl0JVmWBa0KOKwolcHTlQIEYo4hYJN
	 JZFQYHsUCbLYsvcLvIe7eGGsJPed3RU/NOPiMh90XQiMw0iuwfufoFK4/CMdJOBHur
	 Hk8yE1H5lXIyw==
Date: Sat, 14 Jun 2025 12:04:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
 <brgl@bgdev.pl>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v5 00/11] iio: adc: Add support for AD4170 series of
 ADCs
Message-ID: <20250614120444.491b4e00@jic23-huawei>
In-Reply-To: <cover.1749582679.git.marcelo.schmitt@analog.com>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 17:30:40 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Hello,
> 
> This is version 5 of AD4170 support patch set.
> Not many changes from v4 to v5 and not waiting as long between the previous and
> this new version so, keeping both change logs below.
> 
> Thank you to all reviewers.
> 
> This patch set adds support for Analog Devices AD4170 and similar sigma-delta ADCs.
> 
> Patch 1 adds device tree documentation for the parts.
> Patch 2 adds basic device support.
> Patch 3 adds support for calibration scale.
> Patch 4 adds support for calibration bias.
> Patch 5 adds support for sample frequency along with filter type configuration.
> Patch 6 adds support for buffered ADC reading.
> Patch 7 adds clock provider support
> Patch 8 adds GPIO controller support.
> Patch 9 adds internal temperature sensor support.
> Patch 10 adds support for external RTD and bridge circuit sensors.
> Patch 11 adds timestamp channel
> 
I took a look at this version and FWIW I don't have any comments to add
to Andy's review.  So we should be good to go on v6.


