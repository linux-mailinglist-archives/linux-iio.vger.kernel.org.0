Return-Path: <linux-iio+bounces-9706-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C8197E38F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 22:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784A428104D
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 20:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B497441A;
	Sun, 22 Sep 2024 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiXmt5m7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B441C6D;
	Sun, 22 Sep 2024 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727038780; cv=none; b=CWEl35lViapjsAmejo5sWgbB+JMG6QxXPCW7WWRi/up0MpwqLRDqX6ZWjrRPG7HPLCdHOzH8sbTYjTAk+fDW3FnfOPeG6FiS+mHZ8/UOZ8QlbcekqKpi4ezth/bSTaZqQpyKRiwcF0r88EdGkk4WI38OifQ5gM/p9d4vQIW365I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727038780; c=relaxed/simple;
	bh=LQMmoUnLkiG5ycqe2dPDOl4lYMnY0696ai+MAXVLNTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKxLkrU7zJYDeA7n1RslETrkqgrV1eUZFpP2H4Ds9uN84ZvUY9VB+q7gYaMHEE3U2SPnhevB1NOeu+vmE1ozvhV9+63fWUyi0uzD8B1yl8GVp8ET9usUeJmME732DdvwxyqFyO/b9c5v5Xu5QOtDkHZGR+LdMS5JYOU/pG9LwgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiXmt5m7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFABC4CEC3;
	Sun, 22 Sep 2024 20:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727038779;
	bh=LQMmoUnLkiG5ycqe2dPDOl4lYMnY0696ai+MAXVLNTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BiXmt5m7+b9ZXJ7Vb54iejmA91YDD/X6zlg0NGOlwHFoDXmdoFCGscyXPIcUoHMw3
	 JoERIATpqaxlLXjigoT9qMnk7aZ+Xv0K1OuPSsNrvRWpuQAV+Gh7TYuXWOFUxRO9/W
	 DhcLGXr6ZvGCmkwJ6rL+C0eOa3QjyoEECd21w8tY1eHQqB0FnrxQocWjTNg9TuRj7e
	 dCA6zGox8edyfnck3+zCyQtqM8CwYyuq1BAYRivCsxBxN8EF8iQlBQXGDr+dkfb+BT
	 4Ruxkffj4/bYWw23QAD+yQg41pTzkO3s1cuGvpvCnIvjh2z9tYrlqS2WctNP317Wuo
	 ANlANiNNT5eDQ==
Date: Sun, 22 Sep 2024 22:59:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v3 03/10] dt-bindings: iio: dac: ad3552r: fix maximum spi
 speed
Message-ID: <t4jcxkbruvpawnf4xvb4i32b6vrru2ktbyvyriagxgmmriz7mq@dcvualh7cgc4>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-3-a17b9b3d05d9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-3-a17b9b3d05d9@baylibre.com>

On Thu, Sep 19, 2024 at 11:19:59AM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Fix maximum SPI clock speed, as per datasheet (Rev. B, page 6).

Fixes tag and Cc-stable.

Best regards,
Krzysztof


