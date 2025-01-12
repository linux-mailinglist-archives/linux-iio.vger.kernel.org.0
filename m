Return-Path: <linux-iio+bounces-14231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89431A0AABD
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932AB18877A7
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39B81BD9FF;
	Sun, 12 Jan 2025 16:07:09 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F31BD9E5
	for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2025 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736698029; cv=none; b=b3kMI8Q+iygHxCbGB2N4QbqjwU7bC6JGymhYoFAOjt22/ckFBvJgsHgAXo3TgvjNgGlNy8R8I5Qvg4P8vq1M5tBR7KLN0ePBJT53zSjNQ8A59QMcwzGqB5VPf0pWlkOiLXtDzm6fj6JojDEgd04o8rfcSbnrnhPTTywnZhyNn3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736698029; c=relaxed/simple;
	bh=JTjTLp5iJvypONGKPH40NlLTjGcr1/D/FU5oACqWNoM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcAr3iduSW95ZsavVwrOFu2cRCui0pKoIa9Y2mO+PBbE7Azllt/YOf8LVonom3Tc5n8ELlUGcY/rQJSW9ZigRIyRwW02/Q47Hz03rIp/w/6xQ5cr+AXlVgUjHP/ljsPxYQ084WHoOpHN9c7DDVVw5h5YuCVbozL2J9pjMr6M5RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 40c96eee-d0ff-11ef-a20f-005056bdfda7;
	Sun, 12 Jan 2025 18:06:59 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 12 Jan 2025 18:06:59 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v9 0/4] iio: accel: adxl345: add FIFO operating with IRQ
 triggered watermark events
Message-ID: <Z4Poo4x9xvBpdeso@surfacebook.localdomain>
References: <20241228232949.72487-1-l.rubusch@gmail.com>
 <20250104130916.5a25b5bd@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104130916.5a25b5bd@jic23-huawei>

Sat, Jan 04, 2025 at 01:09:16PM +0000, Jonathan Cameron kirjoitti:
> On Sat, 28 Dec 2024 23:29:45 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
> 
> > The adxl345 sensor offers several features. Most of them are based on
> > using the hardware FIFO and reacting on events coming in on an interrupt
> > line. Add access to configure and read out the FIFO, handling of interrupts
> > and configuration and application of the watermark feature on that FIFO.
> > 
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Series applied but with a tweak on patch 3.  Please take a look at the
> testing branch where this will sit for a few days,

I would expect the comments I gave to be addressed as well before going to
upstream, but sorry for having a bit prolonged vacation.

-- 
With Best Regards,
Andy Shevchenko



