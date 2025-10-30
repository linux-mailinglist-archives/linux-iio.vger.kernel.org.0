Return-Path: <linux-iio+bounces-25638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5EDC1EBD9
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 08:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACAA44E7260
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 07:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EB8336EF0;
	Thu, 30 Oct 2025 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MtfuH8St"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7272334363
	for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809278; cv=none; b=CAqQ3wc6r/QmKttoPIT3fUPYx5PyhHmK/mCnlcQ1uGeQZzz6AdkjFYplai/8ArNWFBXNZnSI6u6GOFcJROPUraWgZOmogstnfW0/eI03gkkrax1Ld1QdHtral1lYTy5UTvuAXKe/XBzFrtPmTLzP1r9bn4mjMFJ3IG7XKeqUmHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809278; c=relaxed/simple;
	bh=6xuAztGGf8TPMrJnMQ/MnAVjKV4Phxg9JewUCE4DOdg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZKJhMCA3vw+21t68BkyXTkdtxePfw7rw7e78DWUPF/UFws82ahtAlYtyMkoE91YNs61ZM2jfFMSD0ouYmzmC119wS6CeLoZYMM1OacSGZJNHSOJ03zzBp9H2yR04b3iEb0hbukmlcPalR9VG+1npGTbb/tlzdh430x+2Pzzhsaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MtfuH8St; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso1404748a12.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 00:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761809274; x=1762414074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/6QatJXbzJQcBlbsN/zCXF7ei4jcjtpQXjiRWlC65CY=;
        b=MtfuH8StwX67Enp1wbJuGfxfx7XLviroNfR3AxlO0LVvWz8z7GwJQtAnZj739cm7tu
         epzXNH3+ATAv7rgN0sjI51tNGE84bDt+Cz7teJPz/ZS7z0+zADnXgZvqW5HBgHI8rCqA
         fvRoutsjg2vfXOa6kMYnuRYJ77/T9Y2BXgsyORmfNpj0azDz6HQoHxiQXDXtG9y+Wnq9
         wtWbqcIxeFraYLRVU19s7RbpXVlRm74fu4MeYqHZ4xh3fMJPvcZwUjejc9Jn8Qpf4qwp
         YiiM+qtJ8FZkh1uIpR2wqEq7N9k8OQvzszRk7ShkXxghq1QGTqAk2KwqIlGDvtncxNzq
         sOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809274; x=1762414074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6QatJXbzJQcBlbsN/zCXF7ei4jcjtpQXjiRWlC65CY=;
        b=Oqyj2yF4otlVJrDN4HwgBGfWOcTZmzUCewh0VE8heDCw4qQl/PpiJWS/IZ0Np30/b2
         Jg6Ege+yFMWrZHP9cFLUHeYuGL+7lLemBDqb/o8APHKyhZZq9M4n/YHo7LJN/YqY+t0U
         6yJSmvTWGz5WSbpumTyyDwoRU8+IxnE7ho+Q4J0F/jFDy7oC+6HhEUowmsQC/AYgB9pa
         opx/TE23R4xzdl2fpnUHek7P4pCzYLlPumuAAIDoy7Ygul9W12V4pmlqyujTp84D2BzT
         jLYwCWo4dIW3o86h0ofCKAw927b3iSKv2RO9K+bjhTz04pUpNaoOeUvew18xsPesdl5m
         aJgw==
X-Forwarded-Encrypted: i=1; AJvYcCVJahvz0NO+Uy6ye6o6hl0c6Zf02+EqyY3VifjeHteqO1+AH+NN8VN3gPLhXgGKb+qEMD/USOtUngc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjDwnb14Nra2Fo8Y6XbAn+z2Cn3MWDs0dmLOne59kJ7IrcokZ6
	0dSXfgFmPAHIAn/TRKmwAthv362/HT3welZd1d5rsPW8L4ba1VEDHBziEMRRUtvB/Fo=
X-Gm-Gg: ASbGncsJTrbRfeD0W2ji1vws+O+Nh4Qy1rvjOH3ukYMXFq1O6Ek69qDOWiy0O3I6N5J
	TrVM9sBG8BhTed+QfXMgL/A7XBDzKgEDEE7WzRJ+2vzXOSOcd7kzzOpfL9e1KWDfv1HxUOhOo7D
	RynXzFUeSGotaB725jeBThn2m40NkuxFcRBvZDEb4NN/pkzxx4EghTRJw0SvZ6tdyEUuXkIGCSX
	CH1rZmZ2gc41TfWc+QEv76RGoja3SOzDXs4gsfyZUYxtZbG9RtbIKhCnq4cZ/CWa0Tmdmek6B/i
	8ggc8yHZkls2I4d7J9dY4di+bWcy26fXtVvm5ZCjYnPJr6wtyD//qIsofv0d29omjMeQVk0HrC+
	ecRP2Ymnr+zgs94NHnMiPhgZ9NLm2rF05HBGJKchqzYq4hXVeRej2KFsk6QlofAv+1RCLWLk59S
	PXJC+3I48H4jUlIADrrmuyTgtilw==
X-Google-Smtp-Source: AGHT+IGDlgXct6G9XzogASDF4gGFGJL+poglAjzVMKWqtIwLalSVX8z4qpJFHXAl0iKUL0PN+OIvEw==
X-Received: by 2002:aa7:d909:0:b0:63c:1804:7da0 with SMTP id 4fb4d7f45d1cf-6405efcc885mr1528938a12.10.1761809273978;
        Thu, 30 Oct 2025 00:27:53 -0700 (PDT)
Received: from localhost (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efb97cbsm14342016a12.26.2025.10.30.00.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:27:53 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] st_lsm6dsx: add tap event detection
Date: Thu, 30 Oct 2025 08:27:43 +0100
Message-Id: <20251030072752.349633-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=flavra@baylibre.com; h=from:subject; bh=6xuAztGGf8TPMrJnMQ/MnAVjKV4Phxg9JewUCE4DOdg=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpAxNEx6Tcn+KW5SYwttXBbevB4f1LJXpj7Vh+f +pmGKCLHTGJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaQMTRAAKCRDt8TtzzpQ2 X1LMC/0cdqFMtF1jQUBOOVYgCN79ShFNncFPt3ROykSnCCEY8Ae3iIlxOGtEdslbwYS3Si7kjyU BZKc85qo06/X8QBYwrzdPBNPv4oG9xDQAtUm9VDvAC7xaQo+fb9BmhI/2hIKSLGHOI3iNy2NlG6 qVDRnda9D5qp1Cdic0EoK1OVi/GuMesZlLGVjepASsZ18vidPbihxLKa3oWpl6q1EfVYYjyBkRO 3IFVv4vdEH3kkVR8bzj0xrgyjZ+7IKSURlsLnMuXoCstXcEMBB5BkyrXerqeIVTIWmw/m580zaQ iGi9dV56sfyGq8TalSaMga8vKNTWCTzIvFumnsjXPSiDwZn7DTyo2nWHs3ZyYFCd2qvNn6jcRRB 40KnBjzbzEPof6sHTEPToaq+tcX2+6B8vN6XO4MvnPjChfBmkVuR287yEqjN/roY9t7+fJmHqBS ecejVBZkd0M27vrXaSfA8/fbNKHhqRRM+uzcfmtL57UOyYeo1OridoH3snY8rupbv7KpE=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The bulk of this patch set consists of reworking the existing code for event
detection (which supports IIO_EV_TYPE_THRESH events only) in order to make it
generic to accommodate different event types. Actual support for tap events is
implemented in the last patch.
Tested on LSMDSV16X.

Francesco Lavra (9):
  iio: imu: st_lsm6dsx: dynamically initialize iio_chan_spec data
  iio: imu: st_lsm6dsx: make event_settings more generic
  iio: imu: st_lsm6dsx: move wakeup event enable mask to event_src
  iio: imu: st_lsm6dsx: dynamically allocate iio_event_spec structs
  iio: imu: st_lsm6dsx: rework code to check for enabled events
  iio: imu: st_lsm6dsx: remove event_threshold field from hw struct
  iio: imu: st_lsm6dsx: make event management functions generic
  iio: imu: st_lsm6dsx: add event configurability on a per axis basis
  iio: imu: stm_lsm6dsx: add tap event detection

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  73 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 653 +++++++++++--------
 2 files changed, 422 insertions(+), 304 deletions(-)

-- 
2.39.5


