Return-Path: <linux-iio+bounces-5191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CE68CC958
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 01:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FA51C21BDD
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 23:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895451494B6;
	Wed, 22 May 2024 23:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="QiiVgGzY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E628080C04;
	Wed, 22 May 2024 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716419109; cv=none; b=rkYWmnbGfQUtOrl0mppehRDYoanAHuHi1DnRrEHtbfJgf3MkM2jdUFkLx0ODAmlkxH/VwnOfIalqQxQvo/x1at6I7/UHluRXVATIrD289vKmA6FADZVGtdseX38Pzpff4myVl9j5H+H9sKGWd61VjQUBVDqHF0A4zAfw0VQaA0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716419109; c=relaxed/simple;
	bh=ziUTCItjs4pwIzMLrxs6a8H8BKosi12oUaXzTdEk+9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6E57kX9mN7xPx44y5wtk2/Ic9wu9Hxhd+dEot5Nj8XOTOUswqPGE8+a/39xy0Ui8azJUzUEpQoHvNhBM1MJhMGpLVizu/Oxz9SEI9ATmrU5mXv1I2Ug27gPe+PG/N5lqbwKPyXojObT8nxvLkO6JMBpKucfwLkAX+hnipvYqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=QiiVgGzY; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=MkecTzVTSWpFN8cR6NW7tQdeCOgZs3Z0mf0F5wLZywU=; b=QiiVgGzYWM6AyeeE
	bsNXeeilmjmH3zRDfwYePM8ubqOqSz3ZVtBUHx6my9cFDPADKXODGhnvMIpqZnhtiW87KRbJyF2+0
	OCjJGmFnWEekSMZdKndLJ6bMJ/rRK7chWqmIN1upY2OOogM/c9VNjCaKcGRTqV29krnRtyOBxWvdH
	YD/TLXhZGEE4s9IPMMcm1aWCzUBcFMXztmKysX0upG2qL0VhlbNGat7iymicoRjIWo4GgDs4VCsyQ
	hURuCdPial5t7uSkkHN3WihHRQ1psphMVkZYa+KD6NiO9k+swf5NRrjH9ugpaIHfUxheik1R9fbmz
	D6HMx5HylsZsEn1psA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s9v11-0027Vk-1R;
	Wed, 22 May 2024 23:04:59 +0000
From: linux@treblig.org
To: jic23@kernel.org,
	lars@metafoo.de,
	marius.cristea@microchip.com,
	mazziesaccount@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/3] IIO dead struct cleanup
Date: Thu, 23 May 2024 00:04:54 +0100
Message-ID: <20240522230457.478156-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  Three dead structs to cleanup in iio.
The bmi and pac are very recent.

(Build tested only)

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (3):
  iio: accel: bmi088: remove unused struct 'bmi088_scale_info'
  iio: adc: pac1934: remove unused struct 'samp_rate_mapping'
  iio: light: rohm-bu27034: remove unused struct 'bu27034_result'

 drivers/iio/accel/bmi088-accel-core.c | 5 -----
 drivers/iio/adc/pac1934.c             | 5 -----
 drivers/iio/light/rohm-bu27034.c      | 6 ------
 3 files changed, 16 deletions(-)

-- 
2.45.1


