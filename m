Return-Path: <linux-iio+bounces-22961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4085B2B9F2
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 08:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8F717A127
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 06:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F76E1494A8;
	Tue, 19 Aug 2025 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YejwJVdq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8182773F0;
	Tue, 19 Aug 2025 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755586547; cv=none; b=vA3qDpe6IYJ5eWHrGM3XOF8TzAZt4o87Fd3ziSVEkoLc8T8a9JXWbYWiSSai4Ccv/CCINC+fupkeU40OJu3meMbY/1eTwcWF7QAMzwWRRbOS032nxvKS4MKmwLLbI5FScEFDMlqvBYecowW36EKovqHqq1x8ufB5jN336yograY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755586547; c=relaxed/simple;
	bh=VEjiVYB6dGqP6d7KmqoewmJsa86D2cciDBCWg80gpNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3GAc0ou5zHt9qRzi3FcrgnwSN9NkXf1xyo5Pju6DvU+EvhS+OBwmF6vt0CZ3Ub+sWpI0ygH6UXNl0Ri5DGXhj8/Tpahixh8vUPpemZ1yd6sZwx3KVa3rF835qOYA1rWzi1o+lTSz1DA9EeH28MpVgFTg1GLF/lXhoB1hKscLfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YejwJVdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40977C4CEF1;
	Tue, 19 Aug 2025 06:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755586546;
	bh=VEjiVYB6dGqP6d7KmqoewmJsa86D2cciDBCWg80gpNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YejwJVdqgFwNx45/8X3SyBis6PDEgsxWdAkSQDQg9nAX8IGSq5xi0Mvhp7VOms6hA
	 ejP557EvyXwBOJ7S/7Oc4zTnmdHIwXv/JuAqsM74rG/zXDwR4OHYO3iv8SF9QtgVNl
	 VUrH1Sz4OdLZwlmc5V5b3VDCYsdvitzBnk4MGAk06LSWb5EJYKlmVNSt3szTFi6M14
	 tFbOQzXVXRf2lmmYITryB5ffK3bMr8L58/MEs6Zso1gijKNkl/SylS15pMwJdlZA9a
	 j0CdAbch2zwOW0FAJwSexLM+g4Wr0O0bqw5kiUNIKReFICfBqFV5C3gi8aZrfMHW9K
	 Il0r8pa7nb3Zg==
Date: Tue, 19 Aug 2025 08:55:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ben Collins <bcollins@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ben Collins <bcollins@watter.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>
Subject: Re: [PATCH v5 0/5] iio: mcp9600: Features and improvements
Message-ID: <20250819-ambitious-lumpy-hornet-bc1600@kuoka>
References: <20250818183214.380847-1-bcollins@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818183214.380847-1-bcollins@kernel.org>

On Mon, Aug 18, 2025 at 02:32:08PM -0400, Ben Collins wrote:
> From: Ben Collins <bcollins@watter.com>
> 
> ChangeLog:
> v5 -> v6:
>   - Fix accidental typo added in dt-bindings: IRQ_TYPE_EDGE_RISIN
>   - Correct some constraints in dt-bindings
>   - Reverse if/then for mcp9601 vs mcp9600 constraints in dt-bindings
>   - Updates to changelog for patch 2/6 (dt-bindings mcp9600)
>   - Cleanup tabs that were converted to spaces
>   - Split thermocouple-type default to separate patch

Please start using b4, so you will get changelogs with lore links for
free and ALL your patches will be properly versioned. git can do that
as well - git format-patch -v5 --cover-letter, if you don't want to use
b4.

Best regards,
Krzysztof


