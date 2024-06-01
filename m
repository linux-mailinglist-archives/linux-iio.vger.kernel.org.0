Return-Path: <linux-iio+bounces-5586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA008D7198
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 20:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F220A281BC1
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 18:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D127154BEE;
	Sat,  1 Jun 2024 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCBUKjfA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CEE4690;
	Sat,  1 Jun 2024 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717267968; cv=none; b=aWVTtZVvGRYmOHMKeEM5aE7aL62eZoXv+iKytJxm5K5uxmlUBw18wLMlSekibBpuu3/TjOdKTgngYPHMKVlXb4iAarvl30oC364hResHrO4djrPXpZda8GWaXZgoeCDpweuODeuryd2syNBdmqyOhFeyqhsCII/m5nTkUnUBykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717267968; c=relaxed/simple;
	bh=m/C48A6NvjxQyszElizmjUNC/XBYr6fEMl1eNt5fgWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoB/wCIizI+enP3UFeNqMHo+6nLWnedohduQ0l5SJi7NZanNjDNe7MnSTR0tq0C7mu9rj2inq8u/TN/IOKMIpzeu/JQkO4NsFcxkGiWwduMs4UHGAWw8xwHiEpUdeYhGoIvq2/tM8ZbpaVdSmXlj/KTPzSyIhHWwK2zFy/swRQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCBUKjfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E868BC32781;
	Sat,  1 Jun 2024 18:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717267967;
	bh=m/C48A6NvjxQyszElizmjUNC/XBYr6fEMl1eNt5fgWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sCBUKjfA7CpF42xieJzP3xOEGtZBAkMasbEajQdDKjfUa9C7XYa1HkCDG3Us/DtUi
	 d8bwcf75qyxS4Nfe8bvSydvauoDu7OPDY9g9Fs8kI8rCc1cvUMoCJOrHQGe3pE0F8d
	 ETgbIOl92dpoOzptFhsgxtKKFxpU+d3PJsWI5vT8dxA50qu16nF9vi0/r0K8YpS3ZV
	 BTeauGxysjUP/L87b3LJMQXk/US/yvm+OJIctU348llbSXmAIjCoMTnswlf+NeeBaK
	 lcOL1LMxZ6fyeVut6f52V8kV6fEAHi1oa4wbW7Mkg/pLvdgH5Dq76BZ9VzY4wu2IFE
	 4JPCut+rcDMCQ==
Date: Sat, 1 Jun 2024 19:52:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v4 5/6] iio: adc: ad7173: refactor device info structs
Message-ID: <20240601195233.20626375@jic23-huawei>
In-Reply-To: <20240531-ad4111-v4-5-64607301c057@analog.com>
References: <20240531-ad4111-v4-0-64607301c057@analog.com>
	<20240531-ad4111-v4-5-64607301c057@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 22:42:31 +0300
Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:

> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> 
> Drop array of device info structs and use individual structs for all;
> drop models enum as no longer needed. This improves readability as the
> structs are pointed directly.
> 
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Nice.  I should have read on before commenting on patch 4 :)


