Return-Path: <linux-iio+bounces-6270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30966908D96
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 16:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECF01C220B9
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AA6F4EE;
	Fri, 14 Jun 2024 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQBCxnLh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A9EAE5;
	Fri, 14 Jun 2024 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375829; cv=none; b=lPwos7qJNc98tgqAEFUhXcHKBDqQVn5EPUao98zjKhTac0X7sHBkC1XY8wH9IW2BVlAKbiaX9sOtB/K0iHf7NI0btXuTQYYr8U4KIAwo8A9wHvttjfejvGiIIYJaFW7U5RkMECfwVQAlB+cB42eimNV5OTdmOwAFEi0bd3+yiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375829; c=relaxed/simple;
	bh=CqxEKJfvF0T3GUJBD8Jm6FdqD1+1lf3t3cWycwQdufc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ABs+jwV0fAywKi1F2vf/fUWAbtYwaTBNAA8WjkqYB1yqY6QTamFimzkMNsgs/swi301Y6YMcZ6fLs3wK+N7hg+nf12SDo8pjWO8QWfJ9lwq9EJzIj5uJWntZWf3CT4Y0wdNH/44bkQv+UXow6ei+ToTXY4D3nApt8VD0FimOcso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQBCxnLh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6fd08e0f2so17084845ad.3;
        Fri, 14 Jun 2024 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718375828; x=1718980628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jGaRzs2YeDfss0WnIYDXvC9VI2jtEtGa0WdK+noWbmA=;
        b=bQBCxnLhHDJP0aXIh42Q1qi9QeLdvMlV0Q6TYNIwrZbGTDP8lPhtSToSeBVDoRMhqF
         /Fz8CSF+FJkTFwlGvHc2ZGyq2PuZIbhIJ44wrY2/yiwZ6S+zpSy6x7yuGoAMpQwu2nTi
         8Zjf5TUDzzCHGfeLRbC8h0clN5QjRVvCjNzMK/bRw+PYd+nD1QyTMw8Z7uJWYfFJrowK
         4AYt6U4PzX7s6POqvq3X7xPlvh3nW/vY32XZqX1T4G8gjXRSnwJ8N0+VUNiONvSxzFsN
         kOnjo/T5Jm0DeSLY+bi+aq/pqbNp268tKZjkLlYtb9v5flDUVuKzVAVNZdi7NeRcXnUH
         Ahqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718375828; x=1718980628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGaRzs2YeDfss0WnIYDXvC9VI2jtEtGa0WdK+noWbmA=;
        b=i0QERzmLNgEis+wELgOqNcgvoHRmgKSGovmQkeevWJHmW4SU+rp3nzLh0TilhCyBbS
         13v7cc2LIQzns3wGWCoQwQ1v8aPs6dfX8KbnNrisEjd7GlCzg2zy/Jmb1Kzd1VyyFBJY
         lQskW3B1CaB6idJS/Ps66bA0+o4NozO4aQds0qCDwj4w7WCCeeqe33G7t1atSn9RBjvG
         FSHmu2zs9FmsrSVnIiwZpktf467s2fPL5VPxlJRXDNcRHVK9i+8p6beEKkVmfG2t1UPP
         g2spcXH2SB09ndUxU0rZK0a2y4pinGFdMIKXWwkSwEmYH63BJl3sdQN7DMvsb8fzdDTZ
         K4qg==
X-Forwarded-Encrypted: i=1; AJvYcCWCoR7WhrYIPUTRKwosXiSIFBHAr5Glz6Hpkpts6QbXS6U2VMcKXNPX7/6tgDQULbQl0cgrsVuWXnD9MOIj4y0xtMmNgt0sBUSZQ6acTuBDOdwkVDm/J8evJuUCLd6EiIGup86qAryJEWHB55DQ+0p1WnvB0u/IHdhoZaKGgkL4
X-Gm-Message-State: AOJu0Yxho19iMXV9ztWUbsLGi6Go9K2/22UzRL130gUOWNx7ktO36KIz
	1vlBGJ5XVVcCxPWo8Pk+Dsz7n/Vcl9oF6WLwHfmIhZ1MDBDOAoQx
X-Google-Smtp-Source: AGHT+IFM/0oolWKKXUd4bovtkt9q6nvnm/QqHT/gKWlpnIFHnNWCfFTeLxW6RDMtiL2wY20/yExaOQ==
X-Received: by 2002:a17:902:dac1:b0:1f7:3217:3539 with SMTP id d9443c01a7336-1f8627cc42dmr33252315ad.38.1718375827758;
        Fri, 14 Jun 2024 07:37:07 -0700 (PDT)
Received: from joaog-nb.. (201-13-139-53.dial-up.telesp.net.br. [201.13.139.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e6e42csm32720855ad.73.2024.06.14.07.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:37:07 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: trigger: Fix condition for own trigger
Date: Fri, 14 Jun 2024 11:36:58 -0300
Message-Id: <20240614143658.3531097-1-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

The condition for checking if triggers belong to the same IIO device to
set attached_own_device is currently inverted, causing
iio_trigger_using_own() to return an incorrect value. Fix it by testing
for the correct return value of iio_validate_own_trigger().

Cc: stable@vger.kernel.org
Fixes: 517985ebc531 ("iio: trigger: Add simple trigger_validation helper")
Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
---
 drivers/iio/industrialio-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 16de57846bd9..2e84776f4fbd 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -315,7 +315,7 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	 * this is the case if the IIO device and the trigger device share the
 	 * same parent device.
 	 */
-	if (iio_validate_own_trigger(pf->indio_dev, trig))
+	if (!iio_validate_own_trigger(pf->indio_dev, trig))
 		trig->attached_own_device = true;

 	return ret;
--
2.34.1

