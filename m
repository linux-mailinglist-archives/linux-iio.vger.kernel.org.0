Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F44923F784
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 14:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgHHMO2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Aug 2020 08:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgHHMK5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2020 08:10:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33546C061A28
        for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2020 05:10:54 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kq25so4760525ejb.3
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2020 05:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D2hXjWV+Su7SyzOjgKgoYJpz+6E+ZQ5ynmL9qrjMvwI=;
        b=cWjYfVl6qJDE6NyhUy7/UB9flUt/T86iuRQBMa5PL5BeddTjpUF+EPg0fZaKLqW4AA
         NXY/cbgHqmB75Q6lZbLStYBxi2DXBQSYSymS95NKbQ+vuuLRk+pdO+kFPANQophFnWzc
         l0ZJksdSIH7bVE1WB5+sTz1ysesa1wcSnstMa0nr9DF/TBPMN6HLUY/3JJIC6FIZeQXA
         5hWdToTUzAkogy8SbYrtOGVx/86oVdn7niWyrK8759zFOw+cv7BCXVcLD2owC5TYZpXA
         1jmOkPxRw7hjswrmf9oE8UsHiIpWUh5rbMMOtQjjBE5/pPw5l+R/X5OHjtRUCMEK0Sng
         U9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D2hXjWV+Su7SyzOjgKgoYJpz+6E+ZQ5ynmL9qrjMvwI=;
        b=myH5Ho9zjcDCQyYGVGfGpvyxllUJ7cYeNZoVFRve2bm74rbWmvZ0aFllUSNfgyuFPA
         lGy4EqOteUC7dHytvtkpQUVvExhQ7GAl52Wa0E5M5b6ofjJxSkTo0E21piNJMd0ixOHa
         Jc00sjfNjiN/OcY0NsMMPUgXnOWoKBWmZ1q93zKwuw/MqJs+RrxoWYeqysVhqBp8pJ41
         ngF7k0Jh+E3oQYvLSJpy75FCVvlzj9b0xj4Ej5yXsGiXN/Yykb/MOkjVjWEsD+5e8QUw
         fdUnq+kOsWsgLCbUdW7+VkV1106VIdd4W2bAHAhJwQcThmNwBl/w8BDDkuY6YWAS23DX
         C6RQ==
X-Gm-Message-State: AOAM531VOf0prhZn6+Fe2P1w4YGx54oJGoO/q1IL4dy9ikA28Iacyhxe
        +YCWWRZf5jRwJHJraitHyWZErQ==
X-Google-Smtp-Source: ABdhPJzgmdjIlMg74g4gc/3gfbiL+mo8XPUq/KwnPQLc0JNolNcTSpTd7m12QqQ8Vg0JELOJ7Ezcdg==
X-Received: by 2002:a17:906:dbcb:: with SMTP id yc11mr12988891ejb.399.1596888647537;
        Sat, 08 Aug 2020 05:10:47 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgywt9p1tstfsdfc.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:b0e6:1cd9:30c1:35f8])
        by smtp.gmail.com with ESMTPSA id b2sm8130833ejg.70.2020.08.08.05.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 05:10:46 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v4 0/4] iio: temperature: mlx90632: Add extended calibration calculations
Date:   Sat,  8 Aug 2020 14:10:22 +0200
Message-Id: <20200808121026.1300375-1-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since the second patch is dependent on the first and was still not
merged, I have decided to send them together. First patch just makes
second one more readable as it splits out the repeated calculation and
that enables the second patch to tweak the variable to the new
condition.

V4 review comments from Andy Shevchenko <andy.shevchenko@gmail.com>:
	 - Move the function creation for Ta4 to first patch
	 - Add kernel doc patch for documenting internal struct
	 - Add patch to convert while loops to do-while loops for
	   polling

V3 review comments from Andy Shevchenko <andy.shevchenko@gmail.com>:
	 - Change commit message text to more proper English as per suggestions
	 - Drop unneeded brackets and parentheses
	 - Use defines from limits.h
	 - Remove userspace typedefs as leftovers from porting
	 - Testing of timeout loops with iopoll.h was no successful,
	   because delay between measurements is 10ms, but we need to
	   fill at least 3 channels, so final timeout should be 40ms
	   which is out of scope of usleep function
	 - Fixing some typos in comments

V2 review comments from Andy Shevchenko <andy.shevchenko@gmail.com>:
	 - Convert divison back to shifts to make it more readable

Crt Mori (4):
  iio:temperature:mlx90632: Reduce number of equal calulcations
  iio:temperature:mlx90632: Adding extended calibration option
  iio:temperature:mlx90632: Add kerneldoc to the internal struct
  iio:temperature:mlx90632: Convert polling while loops to do-while

 drivers/iio/temperature/mlx90632.c | 251 +++++++++++++++++++++++++++--
 1 file changed, 236 insertions(+), 15 deletions(-)

-- 
2.25.1

