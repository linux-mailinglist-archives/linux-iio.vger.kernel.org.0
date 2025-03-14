Return-Path: <linux-iio+bounces-16824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB67A60C47
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 09:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7858817D4
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 08:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E241DC9B3;
	Fri, 14 Mar 2025 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Kql8FUDU"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24941D7995;
	Fri, 14 Mar 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942417; cv=none; b=S+vsooR5zmjfkaqMye3AwywsDUCkF1y7O1/pjalI08CE/r3Sz2mSw1zhtcCGD5JWAATe6WQIDP1bvFPPX/FFVrhZe0/06dLHSia0Q6JxF4J8uvPfhpiH7hGnelxJfl9vmNHF9Zy8mj0yzK7XLTMhMiqe0oEI6MKmW1CiDlbGTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942417; c=relaxed/simple;
	bh=Lb2brasLmXxFUZ5PYKeX8+kW9/EYKz5KnLrvoiEwS3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyanmBsiSmyPS1s0LtJXYhs1l6PGRXO7lk96F/xAJl585qS6rXGfxwudGoaD4atKVbRSeClV6jqpvWMCcRl8lWV6BYzFtruM+063YAkHJIsuEnjPj795ZtsPsD6XqsNov4Br4QTMcnqyl6Bc4UIq6JhuSsW+fkOw+5C20QqtTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Kql8FUDU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741942407;
	bh=Lb2brasLmXxFUZ5PYKeX8+kW9/EYKz5KnLrvoiEwS3s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kql8FUDUwJOtf2ngUAwFIngGhnqhy/Ot5/oclRLWrlyj5I0foexVQfTV0Q/nUGT4q
	 txV1CBScjOXIZa6poTuapxE9mvBGaeq5ZaP/KNI9qGj0cX9pyU0HIS0YRS1eg42J/j
	 Gzxf3qcXryNFqhRj4EVeOuhidiAvfozxc5OuXlgRpOhqrokC9jMzirPmjiOnUSS1rw
	 XCqOSEu+u0n0VkgJAGKRNlJnVgo7NEU1R4pXk2GpqPESO/A4c+mRJU8I/3u3GBaNgF
	 gPWfxNw4YLv0stIERWEDgxc0XoBV8vX6/ZR+17/3NPqUegG8oUPCf4lg/wy0HTo8IV
	 4S6+O7Thue6uA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9586A17E0E37;
	Fri, 14 Mar 2025 09:53:26 +0100 (CET)
Message-ID: <90d1c0f2-b037-482e-a569-f75b713e3a71@collabora.com>
Date: Fri, 14 Mar 2025 09:53:25 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] pmic: mediatek: Add pmic auxadc driver
To: "Lu.Tang" <Lu.Tang@mediatek.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sean Wang <sean.wang@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Chen Zhong <chen.zhong@mediatek.com>,
 Sen Chu <shen.chu@mediatek.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-gpio@vger.kernel.org, Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250314073307.25092-1-Lu.Tang@mediatek.com>
 <20250314073307.25092-2-Lu.Tang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250314073307.25092-2-Lu.Tang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/03/25 08:32, Lu.Tang ha scritto:
> From: "Lu.Tang" <lu.tang@mediatek.com>
> 
> Add pmic mt6363 and mt6373 auxadc driver
> 

Can't you just add MT6363 and MT6373 support to the already present
mt6359-auxadc driver?!

Regards,
Angelo



