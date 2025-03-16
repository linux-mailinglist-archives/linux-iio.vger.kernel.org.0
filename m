Return-Path: <linux-iio+bounces-16896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B95FA63556
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 12:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5E707A2764
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 11:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F471A23BD;
	Sun, 16 Mar 2025 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEN5xZRl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305984A06;
	Sun, 16 Mar 2025 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742124423; cv=none; b=qsqX99Zz9u9EbiMeH/Xb1oJiO96u7FzKd45WnB/+ZXT0W7Fo4O5gW2XYzp6ILVyqORPcsxRU3K6RLJsyHAmVb6rhpkZVnuldga8/R2jt6cvdFRP431uz2tmWPLgQO4ktIR47gN9Kmz99LOS2hlFBFp/GX7w+DhxBbAdRKMzfOOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742124423; c=relaxed/simple;
	bh=39GgW8NFBpkhbqdVPJgxJz5ymMONJWaSBLc/3A5906I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7S5qa+79+8VFLPVNNCd5pjL1cn+4PawxE+PSJ+nELtDzUf3hsMIx6azEvCVDSF+OJ8Y6vS7+VkEEK1LWXqY/quJfZFzDeSqCIcoEbRy98SuKzHLrCTeNcfS5k9lq29XMsm9EXL15lTxw9wWeXkb2zHUnQLcKdmyt0yYw4fFM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEN5xZRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BAFC4CEDD;
	Sun, 16 Mar 2025 11:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742124422;
	bh=39GgW8NFBpkhbqdVPJgxJz5ymMONJWaSBLc/3A5906I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CEN5xZRlxNjpebmA3ebZ2r2BQsFMRy0xiRx2Mk10QgsD4OWXZzZAbROhw37fHklUC
	 CKd3ff6yG+8K6NjFKpG/2CUK1FWpbRcOY+p8tKAvvmkSlhjMt3iHzeIis1qvW/sV6Q
	 URV7QBSdonYv5YEnEBWLPxA0xtKmUSbZKIgZtI4Xjjpb9NrPObB8KY+Ov8vxZJj0sV
	 1VYYZ3ydl7j9lU34mQdlbp07CHoMKTYvaMFMne0PWeSQk3Y/ScRY2Es++W8jQ4OCMR
	 jlEXh95afefSBdkShPOL2CvYlQw2FVE159Ebq4K7/cI0yxbqUMyyzck5QgOLc2evZw
	 6S+XdFeA2iw+g==
Date: Sun, 16 Mar 2025 11:26:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v4 09/14] iio: accel: adxl345: extend sample frequency
 adjustments
Message-ID: <20250316112648.6f5351c3@jic23-huawei>
In-Reply-To: <20250313165049.48305-10-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
	<20250313165049.48305-10-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 16:50:44 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Introduce enums and functions to work with the sample frequency
> adjustments. Let the sample frequency adjust via IIO and configure
> a reasonable default.
> 
> Replace the old static sample frequency handling. The patch is in
> preparation for activity/inactivity handling. During adjustment of
> bw registers, measuring is disabled and afterwards enabled again.
It's a good feature to have on it's own. I'd drop the reference
to it being in preparation for the activity stuff. Maybe I'm missing
some reason it doesn't make sense without that?

