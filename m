Return-Path: <linux-iio+bounces-8184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DD5946913
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 12:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5971EB2195C
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 10:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D258F133987;
	Sat,  3 Aug 2024 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnNEjIVE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA38847B;
	Sat,  3 Aug 2024 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722681262; cv=none; b=tUVTaeCB+pMH3Ib2FBzmKy2lmS3uAvEuGnGlmzhAluURYC4nUPUI4rO5dNAPh/eaj8KaBwEskaHtuwKVRns39Bv00NgaxTvmOJ/QDulqDNBzlGePRqcAmiuFlfJf+D9bw2tLxpQBWYKjKBxg7UgNQRg6m3RRV2I377opofqk78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722681262; c=relaxed/simple;
	bh=ZFEWPndg0yVqKFM40OaGfcBaVW4yzt0hxy//IAKCYYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PucIq+/NO5R4M7KtkG0MEX86RUK6nSWnTi+bYn3A8T4hi+al/PWTr9/bfqncnjEv4iKnpNOQK7e2N80bMxmWRsG9TjhQtDSlJzJhdKLlxGyoYW4N/eDITJ9vVja52B7J0HXYfS8460LH9N39xpngOY4kQx60UkM0UDtleZNRBkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnNEjIVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B299AC116B1;
	Sat,  3 Aug 2024 10:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722681262;
	bh=ZFEWPndg0yVqKFM40OaGfcBaVW4yzt0hxy//IAKCYYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pnNEjIVEP/1T5+JDdidTKFewBRuNR14ytyQgY8+QYC0GayR9WRBEg+XoRlr94xizG
	 QaP8PH0GniRllqCfaxxwisZkBdSi3skx/EbDm6yvoXxZbunp52iiqMdXoVVBKxyGvE
	 uqDtbcQLm+Jwzg7qwEnYPN+ArBznMGD82E45NyiwQAUvllaNyj9Yv8M9XJyT9Djb3R
	 su9UrUQD1xDemdLSgA9g/UzOgJMGbHYgtmMRi0iCJxefYNkrvH+3AX7aEZ9/YolK0X
	 7pgbz0eorSPeExjh5ZYGyRMlQRwx/+t/CLlmqO1gEXQ9DtCNez09bicsVBr6CWzEcs
	 l6w0wcKKSSvMw==
Date: Sat, 3 Aug 2024 11:34:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/7] ad7380: add support for single-ended parts
Message-ID: <20240803113412.249340a3@jic23-huawei>
In-Reply-To: <931de9a9-f391-4609-b067-eaf5c5105451@baylibre.com>
References: <20240731-ad7380-add-single-ended-chips-v2-0-cd63bf05744c@baylibre.com>
	<931de9a9-f391-4609-b067-eaf5c5105451@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 08:46:38 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/31/24 2:05 AM, Julien Stephan wrote:
> > This series will add support for ad7386/7/8 (16/14/12 bits) unsigned,
> > dual simultaneous sampling, single-ended compatible parts, and the
> > corresponding ad7386-4/7-4/8-4 4 channels to ad7380 driver.
> >   
> For the whole series,
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Nice series. Applied to the togreg branch of iio.git and pushed
out initially as testing in case 0-day can find anything we missed.

Thanks,

Jonathan

