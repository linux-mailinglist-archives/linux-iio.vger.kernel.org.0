Return-Path: <linux-iio+bounces-21126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4880DAECEF9
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 19:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA1B3A6D1D
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 17:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439871C8606;
	Sun, 29 Jun 2025 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqioPdfT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0104A5661;
	Sun, 29 Jun 2025 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751217512; cv=none; b=NDBhyb6vc/QEO/k1MegBpgDVzFrVcKKGbRckpdIs263Q1NHJl2cxo74NY2OBmU2+Hkq+I+bBSSyTvQsNsz0xDJkAQTQ/YAEIXkb/IjMyprhbl/iXJh4LAheuCQx9nb+4Ih5sXC1TZJ8yE5/YyLSomP6uUyY4t6OrepK6V2qt1JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751217512; c=relaxed/simple;
	bh=J85DPOo1AhPX1684rWpzzex+GXfQ49XS6lpNLgHgCkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkTl/gPS9xOMpD8Tj9j/daurSZ+iSoVBGCGz1CLhNIgQk/DzTpSCuqZzMmoO4Q6gIWAEKUpBk3CeVQV8xzlDGg2IVRXCJm3d6A60fw++hvGLziB5+/IUCe7nc2utCY3kdeH7UUYLURZXE30rogbLI61J0QArfeIfRa/5NUS6whs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqioPdfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A082C4CEEB;
	Sun, 29 Jun 2025 17:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751217511;
	bh=J85DPOo1AhPX1684rWpzzex+GXfQ49XS6lpNLgHgCkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MqioPdfTZazKXe7xYBTQf9Wy7d09X5/XjJOBy7fbgb0PJI3N3AyTODZYLYukla7ST
	 AKtMsodEDMm0R5H+NLPg1D7PX8vit8Tzx1/8ePFiJJev2HWDmg3iE4YVGMd86iuER4
	 Nnkd8Z7f8Uk+L3N/qSv1J3Av+8+7x5pwqfvmbfd9Cc5AduYASFu7N8+VCaGW9FYYIu
	 B63cS8ANw8A5SS/MeAjvXDH/jiPqfTUnZDVfXbVBF+Rm1bgpYAOgzmB90tdFjaKbL1
	 ATdSZbWZny2MhJOOmAVve1H+kjdpOTg1AGevwSbqeFWwx0+kUmYkeQw1TmSLRecd/X
	 a1OjU/SYO66JQ==
Date: Sun, 29 Jun 2025 18:18:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: zopt2201: make zopt2201_scale const
Message-ID: <20250629181825.1b9703af@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-22-v1-1-fc9ebdc5f5c3@baylibre.com>
References: <20250628-iio-const-data-22-v1-1-fc9ebdc5f5c3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 12:56:30 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct zopt2201_scale zopt2201_scale_*[]. This
> is read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.

