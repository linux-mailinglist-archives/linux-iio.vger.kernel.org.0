Return-Path: <linux-iio+bounces-24167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CF2B59AB5
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 16:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA254A0D98
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA003431E9;
	Tue, 16 Sep 2025 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3YsHRCc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED09341ADC;
	Tue, 16 Sep 2025 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033630; cv=none; b=m5bXq4NGH/J8Oz/iM8pXjXHrbNOdh2UZADTjFpTUeDDEL4vU/HdGwO3jnpw6+ViUJdrJPEl6u3otY7t3gHs84yfWRMprWlv1F94NFfoLWaxMyXFHMp22e6kP8ufZiyPT482yjlinev8hu6Z9kAKdXBBcK59B7+Da9NheKQ3e9QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033630; c=relaxed/simple;
	bh=Sxui93Lb4TKePQ7FNUp2DMIuwMIzlLbOgP1AEoAGFrk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kMhIGez479LIPhfS2HelSSpJqK2/AKy/wKsagXQOmb0HSrsM/Nx3sfsGEiWk1nMlZfQh1YnJ9JOqDgKXwUjH7d/3uxKAgDnJl5RMLkAiHUtQ5Jcpa20A4utUqxqVmmxZaiv/t0xQ6o30dy2mgfU+cwbPTzqxc/T8NF6dAm1B6vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3YsHRCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D355C4CEF0;
	Tue, 16 Sep 2025 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758033629;
	bh=Sxui93Lb4TKePQ7FNUp2DMIuwMIzlLbOgP1AEoAGFrk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d3YsHRCcSWtkIv0o6206LG9NwOhE28QCPw6pJTOy0e+yZlfW5RvrbaUvrWx9s3p5M
	 faJQ6YypDriNartZXHrPytytRcRGKZ14UvBZ4cGwh4BqehbXo3VxsO2qO3COQI+Olt
	 6zGqzoz9R6wQxpZijnR1kCm8J4anK/7d+hMb8EDvfyRYVCBHqHnh4Lvq++Jry5cSNh
	 Mn8pt+0kiiXMUc9zOck3zgeFDr4Y0Rpoy98kWojSliuwCMrgPPB+uo8m51oONxG2gx
	 6Lawqf4ATJuhBKBRceqov1L3eQIpbP9ZTu20KNJy+iqvz83PzA4b68qcsCCh/5P39J
	 eX9Mhps1OugLQ==
From: Lee Jones <lee@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Cc: David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
In-Reply-To: <20250911-88pm886-gpadc-v4-3-60452710d3a0@dujemihanovic.xyz>
References: <20250911-88pm886-gpadc-v4-3-60452710d3a0@dujemihanovic.xyz>
Subject: Re: (subset) [PATCH v4 3/3] mfd: 88pm886: Add GPADC cell
Message-Id: <175803362620.3837642.9201115290344817931.b4-ty@kernel.org>
Date: Tue, 16 Sep 2025 15:40:26 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Thu, 11 Sep 2025 14:43:46 +0200, Duje Mihanović wrote:
> Add a cell for the PMIC's onboard General Purpose ADC.
> 
> 

Applied, thanks!

[3/3] mfd: 88pm886: Add GPADC cell
      commit: 5a30f3de5b458f335b49523e72010078b2c22923

--
Lee Jones [李琼斯]


