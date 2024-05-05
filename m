Return-Path: <linux-iio+bounces-4819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B08BC325
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 20:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E25F1F2148B
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 18:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5E86CDBF;
	Sun,  5 May 2024 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGovctad"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8472D60A;
	Sun,  5 May 2024 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714935291; cv=none; b=p8lnRN+TVwxZcIvZQ1aS+raEFUiZZEvEOSFgpPX0Id7WljItKx1WdukgStlTZ3AFf8MEVbpgeQteeFNUpLTrWmzULdC1+QJMJRV/5rCXZ2fJNtHY1p9oDAoF019Pl6+8BkRQzyVUjfveA2z8xJMOIO+spq3yp8k6nIcedyKFxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714935291; c=relaxed/simple;
	bh=Z0dc9g/QPNRwDpUesFsev940uIqTwJ8SGMyjRsdtlf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lqs0FUMjDXFkYqHtjvIFtotghkk3W3HlOTreZWXsBqqyjZXIGzeftF84+i7eF/Y+f9uEUAMowequoFpGG2cg3LFm8nqMD1BtyyR7i0yEBQbAQ3IK6FSrREeWO3KbyDJ3jcsT1X4CyOEEZwQRXxGxaWXmzxC5MF3LHhY4PECXqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGovctad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BEFC113CC;
	Sun,  5 May 2024 18:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714935291;
	bh=Z0dc9g/QPNRwDpUesFsev940uIqTwJ8SGMyjRsdtlf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jGovctadiCKqvkhHIgd0jk0EoHvDn3VliLle/XHdxyNfWiXNyt9zGTK1l0LxP+85Q
	 OzCewL9YTWUFeCoCdy0570pXAsfbANVxkuFE3ZpfyP1xhR5i8MqzcEMdx2gzkVeBP0
	 NRWfOXBym2lBC6lGcp5ePQk1NLyHjJL9tUwFXlrGm89+RjjePIgStvDUqSfZurJ1bq
	 zNUO2TI7L17SWzZjU2A0e+NObkJeG6A7LOfyUyxETzUyoiODWJlPPvgjaAXf8w5wSI
	 QAZfJqYqrtazXcU8PcGNKX96ALc/9OVocbhl9x60U3QEIonzkIOHS4D9xqpjjQWc5L
	 OYe2koCkXqZZQ==
Date: Sun, 5 May 2024 19:54:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] iio: pressure: bmp280: Add identifier names in
 function definitions
Message-ID: <20240505195439.7a1ccba5@jic23-huawei>
In-Reply-To: <20240429190046.24252-4-vassilisamir@gmail.com>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
	<20240429190046.24252-4-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 21:00:39 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> checkpatch.pl complained about missing identifier names in the input
> variables for some function definitions.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied.

