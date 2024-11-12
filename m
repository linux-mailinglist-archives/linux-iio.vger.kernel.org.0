Return-Path: <linux-iio+bounces-12180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B6E9C5AD7
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 15:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281F02863A0
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B939F1FF038;
	Tue, 12 Nov 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ityExVVJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627891FCC66;
	Tue, 12 Nov 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422916; cv=none; b=ZDvbzPVB2Dr90qWEFS6LDreMigqREDlGA8tiX3VjPNZkBZgeL27vJmI7jUAVCfBGcvolqtOchIjI5HEfZCh3W6Ios7rhyXiK5uXzW6RKdHFS7f87qJOUqZczbm/sLMAvACC1/U+Ly2X2w39pHRCi0d8SdqENAuC6DruQS69Z/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422916; c=relaxed/simple;
	bh=LaX258tbxjOqEOTGbrNDUKoUkGa+ThGu/PsjRDKKkdQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ALmwTaN0sEps2MMdvSPwMPZd4+voIt3xAJz9MwrYg0Ksh3SWKjynQVpoHF4BDWziDbo+h6Hw0MwZh+78k4pNMyBJYT7sStcZFp9FCEvpqsmjfyk2YC7aSWPlKHJMqC9cMOv/tCNdwFDGNWE27CS0sIHkk25mjNYGZzKvmCBvpUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ityExVVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A83DC4CECD;
	Tue, 12 Nov 2024 14:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731422916;
	bh=LaX258tbxjOqEOTGbrNDUKoUkGa+ThGu/PsjRDKKkdQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ityExVVJjDuG4ybSOwEhW0G8PSTWwT15xm7SChbAaxRGzsqELtPi4xC/YRZs9d+0j
	 VaIAqJQyAOzU3TqjUu+OxDErg2eb76Q6OyQlSgLeXHD9VV2Lt2DEJE+LUQXqOpPxmE
	 w0JfsmjHnx12YhiTYviaD82ee3Vz9U/Sf865ewvwpxQWqD4CGgBYXrh6d1FfNoi4YO
	 HZ7uxe/lde53fnMZOvUy43+iMdJO6Hhuggk+9zWt9ohqHUMw/4IGFOHsCAPd2/Ng17
	 8rB92hfyxXh2hi1vxP/A60CHceoO4KiD0YKVR5rrvSa4v6XtwlZMX9zLcO3+Ih3wf5
	 kR1hdGVaqzNMQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <efd200c3b5b75405e4e450d064b026f10ae2f8e0.1730709384.git.stano.jakubek@gmail.com>
References: <efd200c3b5b75405e4e450d064b026f10ae2f8e0.1730709384.git.stano.jakubek@gmail.com>
Subject: Re: (subset) [PATCH v3 1/2] dt-bindings: mfd: sprd,sc2731: convert
 to YAML
Message-Id: <173142291174.1055133.1779666527306049052.b4-ty@kernel.org>
Date: Tue, 12 Nov 2024 14:48:31 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 04 Nov 2024 09:48:21 +0100, Stanislav Jakubek wrote:
> Convert the Spreadtrum SC27xx PMIC bindings to DT schema. Adjust the
> filename to match the compatible of the only in-tree user, SC2731.
> Change #interrupt-cells value to 1, as according to [1] that is the
> correct value.
> Move partial examples of child nodes in the child node schemas to this new
> MFD schema to have one complete example.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: mfd: sprd,sc2731: convert to YAML
      commit: f9c7529fdb607a255bb648f0a7550813e311b5ba

--
Lee Jones [李琼斯]


