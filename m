Return-Path: <linux-iio+bounces-24963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B200BD046C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4989B3BB97D
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 14:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0F028DF0B;
	Sun, 12 Oct 2025 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roDk1nbF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E327CB0A;
	Sun, 12 Oct 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760281003; cv=none; b=h8Uu1PhpYks94XCn62BeFfqGnXiFi6m69iP27tE2KE2c25VKg879fj6rUo2e0TrOAPIH4Buoy2lsEc9j2GYSIMAOpUEXYlRV85j1LQteo1/eNijx56opp5VXeL2YbjfMdWbLk+EUT8krwlT33xGEwPIPpLB2+dJQbNMegJPUp3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760281003; c=relaxed/simple;
	bh=SAIq42Jb3Nv3ZxGG+zObQaAHQckSllaPb8BZVj/UD0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/5U37hfSJXwSLzqOjHyaG9U94GUvZpEQVJTERmObiYJvH9gLJHkPjy+zDZ9cTY5G1+YDC/+CGoLsOkAokRc5BgrlEj9PVKGkY1zTYaV1tAPWQglObdt6YvPA01ur8JZFStusZ2bhjUmIJsiZw8cU+PE59GAr5hOmi71cjMtiJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roDk1nbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93665C4CEE7;
	Sun, 12 Oct 2025 14:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760281003;
	bh=SAIq42Jb3Nv3ZxGG+zObQaAHQckSllaPb8BZVj/UD0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=roDk1nbF29lN8/CKixobURmVNCAu65GK8Rm+2eB9Da4Owap5M0GWrbgbjUEPfb1Dv
	 pOaCcRS7OvmQz68qTvGNOfwPci1wmfj9qGfA+NZsnKWxOg8HeVSleaq6PEnkFJLTiy
	 Pc7SNrjQJTOjzDzbPqjcWrOriY1Lbi0q+kQypt6FGcssOwCVNGJQ1F8HL3GltD6KBF
	 rzzB5+Ud+j4wEh03lMKT4ggIUgOOWRzMuJFZ9gNuTNSzEEcijAsfH5m8OxkJZU5OoU
	 p8xitSTTiNBcUyVQJtQij6CGuMZj1YZM2goIU4RnbNlLChKL9t21DAfTZGhrekocNT
	 xfXwe4NIfrqfA==
Date: Sun, 12 Oct 2025 15:56:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/19] iio: accel: bma220: reset registers during
 init stage
Message-ID: <20251012155637.45fe1445@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-10-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-10-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:19 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Bring all configuration registers to default values during
> device probe().
> Remove trivial code duplication regarding bma220_power() in
> _init()
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied.

