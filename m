Return-Path: <linux-iio+bounces-8182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC30946901
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 12:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51C228207E
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 10:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ECC133987;
	Sat,  3 Aug 2024 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQH38mgr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E9223CB;
	Sat,  3 Aug 2024 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722679555; cv=none; b=LFKpUVif2kBOXsERU9q0301S+H6in4NQbSHeCfnipwoIswwtGZuJ634xblJexLHYyiypdCZ/AYEZiWfoaUFLgFbjKcOwecAa3ZWeraB5ej9TGMdG10ekjWKqL+J/yg47j+qAqkF7Za00BCCBNSEt2xkNX0JipwrMbwaPXjfOb7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722679555; c=relaxed/simple;
	bh=IF7DxCVUzFo0p7x5cQc6/Kkj71VQDEWCgggp1uZftUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4JiPqpl1auby9Ybg22nDIKsH4ZtxVpBFmjz5jk08tz+xBWdrFkYm5CpOot0hcPKF6X9XTfJshIt9guHACw8yrl3snJUOg8bBdoWmWmUs2eL24nf6svQH6EG56Nq45sNkX4TKRnKU5vqiZplNlfSRJKK6GhMgOpFSJIDpmFlegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQH38mgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E275C116B1;
	Sat,  3 Aug 2024 10:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722679554;
	bh=IF7DxCVUzFo0p7x5cQc6/Kkj71VQDEWCgggp1uZftUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aQH38mgrX0APxPWtJB9e2r4fslaZWU+OT0FmeqQpqIB7nZGslNRN5gpdb/DVlCvSu
	 wwaa1cvMhZoIbU7EHYxSjSXjLjR+T9T4RDoOrYfvXl5hNcpqw23NMtk2lZwjNEdZjo
	 EuXNnH4eP6k5NL4ck8GtZF+y5NsYTd5F08n3PNEcY9nGoHzrrZy3X5Be9M4U5R23DB
	 boNDZx+e/HbZBqbk6E2zkrYSfBkZAIm3Ru5goC0l0LN/3Xj0lPy2TYj6ZZZXbRSBOF
	 RDCYwlsN2P1/k9T3GKnkjAxL2tkCdqfFFuj2hblZjs0ZQ+WSsfVIBPwW5y3ny54Bts
	 p5A3LImu9V2bA==
Date: Sat, 3 Aug 2024 11:05:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mariel Tinaco <Mariel.Tinaco@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Conor Dooley
 <conor+dt@kernel.org>, "Marcelo Schmitt" <marcelo.schmitt1@gmail.com>,
 Dimitri Fedrau <dima.fedrau@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: add docs for ad8460
Message-ID: <20240803110545.61885486@jic23-huawei>
In-Reply-To: <20240730030509.57834-2-Mariel.Tinaco@analog.com>
References: <20240730030509.57834-1-Mariel.Tinaco@analog.com>
	<20240730030509.57834-2-Mariel.Tinaco@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 11:05:08 +0800
Mariel Tinaco <Mariel.Tinaco@analog.com> wrote:

> This adds the bindings documentation for the 14-bit
> High Voltage, High Current, Waveform Generator
> Digital-to-Analog converter.
> 
A few additions to Krzysztof's much more detailed review.

Wrap patch descriptions to 75 chars. not sub 55.

> Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
> +
> +  adi,rset-ohms:

Please rename this as rset sounds like reset to me.  Not sure what a
good name is however!


> +    description: Specify value of external resistor connected to FS_ADJ pin
> +      to establish internal HVDAC's reference current I_REF
> +    default: 2000
> +    minimum: 2000
> +    maximum: 20000
> +

