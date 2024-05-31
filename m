Return-Path: <linux-iio+bounces-5544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4158D679F
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 19:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11EF1C25018
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 17:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ECA1761B8;
	Fri, 31 May 2024 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyHzAlGy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B8716F904;
	Fri, 31 May 2024 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175142; cv=none; b=GLNJZp8uOqSWXDaf6DJfWl3gQfkOUGHCd0DZMaTfqZnCsO1qn63RuP5mSn/ygOM7Cv8V2YLPLZStOLIcsxGBYP2eUfOAHzaGKluMU0Nj5PqS6SW6Qb3oJO4/DrFG1Dy0EXsd2y9tBY9ey4GqoDYEuZbqaT4s+r4peHIl1YsRff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175142; c=relaxed/simple;
	bh=ojVyu4m/QK0eLUTVMQOzVZ1/YGKhIT0HpeVHhtnOmKk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U6BQM2fHUBKlJACxIJJAy2L3Vsbxt02V7Jh9o1xEgGuKaHxYq0Xw7NOYEYMtDeuDr8L/P7jaQnyRqHkb9JNwOI3/DnQcmzqwSJvsb3CqO0SJzMfIhz+UnKbvE5S7J13KA2UkeZ2eNUANW4oBX10iLKepfMDAbpDPpHRrCjCGLYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyHzAlGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D71CC116B1;
	Fri, 31 May 2024 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717175142;
	bh=ojVyu4m/QK0eLUTVMQOzVZ1/YGKhIT0HpeVHhtnOmKk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uyHzAlGy36mwd/hrJc4dAsxeyBUw+RfUNcOonw/PUWHZC7fON26bUJr9jG6PxPs+8
	 +b64s2p3Kwp9LC40cykPj7lOOCNJk1a2AehDFiAUhwIEKcvoR3vFxaUBZMl79z5OPz
	 FPJou03ZjeF5uFpYjrob/v2hj5gkmunLcAdogQvs4YPnYOr2qU1UYI674FY5fYEtkT
	 bV6Iz9TBwQ6kGqqt2y+KSnIDKZ3O0Rl8R6hRSNb1kBzoIX5s9FQlSLhw1KvIrlTk5T
	 n/ehnIOHOAjzlO1mWH2UnkRDSHieko8+XRtALn6kFf6EAbQWNq0BgUCKU55pJfp1KT
	 NUoC3k6sQFn+w==
From: Lee Jones <lee@kernel.org>
To: jic23@kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, matthias.bgg@gmail.com, lee@kernel.org, 
 andy@kernel.org, nuno.sa@analog.com, bigunclemax@gmail.com, 
 dlechner@baylibre.com, marius.cristea@microchip.com, 
 marcelo.schmitt@analog.com, fr0st61te@gmail.com, mitrutzceclan@gmail.com, 
 mike.looijmans@topic.nl, marcus.folkesson@gmail.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, kernel@collabora.com
In-Reply-To: <20240530093410.112716-4-angelogioacchino.delregno@collabora.com>
References: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
 <20240530093410.112716-4-angelogioacchino.delregno@collabora.com>
Subject: Re: (subset) [PATCH v1 3/4] mfd: mt6397-core: Add support for
 AUXADCs on MT6357/58/59 PMICs
Message-Id: <171717513800.1210753.10558574294552850707.b4-ty@kernel.org>
Date: Fri, 31 May 2024 18:05:38 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Thu, 30 May 2024 11:34:09 +0200, AngeloGioacchino Del Regno wrote:
> Add the relevant AUXADC driver entries to the MFD cells of the
> MT6357, MT6358, MT6359 PMICs to support their Auxiliary ADCs.
> 
> 

Applied, thanks!

[3/4] mfd: mt6397-core: Add support for AUXADCs on MT6357/58/59 PMICs
      commit: fa9d9f4b5588003a955193fe9ff009687541f3e7

--
Lee Jones [李琼斯]


