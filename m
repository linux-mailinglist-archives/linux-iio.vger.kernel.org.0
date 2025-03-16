Return-Path: <linux-iio+bounces-16900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84F2A63569
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 12:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B033AAF7B
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 11:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786EA19F42C;
	Sun, 16 Mar 2025 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sc3hVs8C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3260E18CC1C;
	Sun, 16 Mar 2025 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742125065; cv=none; b=KKd2q6S4X8lRgyLv8qQJGKzWAIIdVa5ET5+FnGhVZgilmB7T1rx/2KTfyUNyrIHS/J2rlSNikrS0Fb+/+Z0G7Eht6jc6tdJ6RJzisMSoWRlxnytZd4mukhH9r8ZpALTPGnm2PRDOYxhr1B8lPdg0CRS0NLIUW2Xi5TRvhyVZOWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742125065; c=relaxed/simple;
	bh=I2iudw03xE9QwY7rkEkGrLFlifCNAI1kgQvUYkt4qvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpkbnBbfaHJXQNyIzPsKi+zWC4PEFYtPrGywWPubMaY3RlSLXblpgylUhGL9TXRRLzV0wePcmTjJh4pRJCWVTX8VOOywUug/u+vGYcgzSLtCArH9gduTOXUxw9KybYtCYnfvdJsQSIcRqItrRuPFg402GjRcKL0XSnCYkffRcUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sc3hVs8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D148DC4CEDD;
	Sun, 16 Mar 2025 11:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742125064;
	bh=I2iudw03xE9QwY7rkEkGrLFlifCNAI1kgQvUYkt4qvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sc3hVs8CpGuMPYGFLDIX60BZ/sIqY7fNWDqjhuXmDR4XC7VYoleml3EWuyz5vjlnD
	 LGe7cLzBG0IpxhK5B7NePlm5yltNfYkBKzHx7cZtq5N1jU7FGiwTpVdvplR08ot/xS
	 D2aB9agU3okEsSzcAt2QYMI4O9xxLoIlhtfKiTu8EKiIS0GKR6414jR7ovb3bnqKty
	 AAtqC1FLjgsGGgaI7ugg+3eAC5j+ROEOOia9lAiC1Gcg0fcecPxtq5ynHpfsJB1As4
	 y2LPbMiHgVJqPN0ZPYfV3fLGjxGB63jKPmVd37y6B2Tkq2rLyAJGAjeBCC9CCYS2Ym
	 1ang3tQsURjow==
Date: Sun, 16 Mar 2025 11:37:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v4 14/14] docs: iio: add documentation for adxl345
 driver
Message-ID: <20250316113734.75359e11@jic23-huawei>
In-Reply-To: <20250313165049.48305-15-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
	<20250313165049.48305-15-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 16:50:49 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> The documentation describes the ADXL345 driver, IIO interface,
> interface usage and configuration.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

I took a look through the remaining patches and didn't have
any comments to add. 

Looking good for v5 being the last version I think!

Jonathan

