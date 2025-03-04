Return-Path: <linux-iio+bounces-16315-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11071A4D551
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 08:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16BA11895D73
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 07:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99F81F8EFC;
	Tue,  4 Mar 2025 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cvs40gUE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2B1F8BC9;
	Tue,  4 Mar 2025 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074367; cv=none; b=b8vjl9aNzSV6oDxQpD9/ugYUun1i8pJ0nVL4MauG444iJ9ZZmsOdgZGiML4L9iGP3NpKrpfjGWX/9uS7RT9eV8hgXMjS7hm5RxgOk16HOqIC5YpSqy4GrLOVJCg9Ijhvz2xaEqs2USZzqXsi79QixEs6ADiDP4CmKn3x4iqjBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074367; c=relaxed/simple;
	bh=fUi7irrO/Msp0XYZH+52BjNdyYaZGzh2oyrpCmkcRR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUntHVoQY3UeXf9EZuOu2IFf0BSG4tlYorIWcQMnRxJjEE7oeGxqZOuEvm27gelPFNR8S24qXAvuWNSD+zEbcQoxaSa3so2oMQmfKQCnNFBwMx87QDiajtapAqFYHmGtOT0S8XrRzTkVu3NsyL6ycb8tJHEyn/xYNmaKtpZrlsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cvs40gUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164E3C4CEEA;
	Tue,  4 Mar 2025 07:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741074366;
	bh=fUi7irrO/Msp0XYZH+52BjNdyYaZGzh2oyrpCmkcRR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cvs40gUEns0ZXfI/qnJCK3C4bGP8ybjlCE4p5nrZNhdZiRybkiA/Mc/r3ANdx0q+G
	 UhpZ9Qp6hvoi/7Bik/ViG+5bAzHAvUL8Ebxu28Jp751IdhmBYV6Gu2V7Aqplp0cqP2
	 P0LoCyBQML0ve09O0a/PyD1WZeRucAm/+RsEVUFu+JtARdhG4pB401rV5l65gOaESt
	 x/Fy2FoKBHpMCF8QNrJvDnq9myoh6QOhJiyr3xeu/9er3PZVMLvYjAIATqoSiSohNa
	 H+oBvBEqLFta0+FyMvw+cO/5r2zlI2Bri0rzKV547+bO9pPk8kHUrk6ixaY4yBdHox
	 RJG1BoeMYuwuQ==
Date: Tue, 4 Mar 2025 08:46:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Saalim Quadri <danascape@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, 21cnbao@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: accel: add binding documentation
 for ADIS16203
Message-ID: <20250304-chubby-amusing-loon-ac7e3b@krzk-bin>
References: <20250303235930.68731-1-danascape@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303235930.68731-1-danascape@gmail.com>

On Tue, Mar 04, 2025 at 05:29:30AM +0530, Saalim Quadri wrote:
> This patch add device tree binding documentation for ADIS16203.
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---
> Changes:
> V1 - V2: change compatible property from enum to const
> 

Please kindly test your patch before posting, instead of using community
as a testing service.

Best regards,
Krzysztof


