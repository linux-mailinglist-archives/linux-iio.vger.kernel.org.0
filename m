Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596C61B04A7
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 10:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDTInF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 04:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgDTInF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 04:43:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA967C061A0C;
        Mon, 20 Apr 2020 01:43:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k13so9836614wrw.7;
        Mon, 20 Apr 2020 01:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FvWDhWISpGn4NECKTMbbAGhGOgcSHURkbEnrDvJMLos=;
        b=avlZ9T8hhK+4D60c+QbITmY+PpA+oISCvv+x0+zVw0TZI2T9hRy3ezvi4EQWm5p9Yr
         ulRTiSrqUSlB7Vh6Wzy1treFQdHNls8hEfF2gpLAS6+MkeT5iHJbFEgZ+c2W6kbY/Wnu
         WgUFyYxWE7FHP635rcDZz02rSAdVkVLQTowgA1lra7/FwFiiGQNeNEa4rpXBJNPvlXVw
         HUco5qQzwtWYSnBmTok31veJLWFwg1J44hBagJfK4YhoQ5mbwFyMjHsu3ru2qzpyQHZW
         nYX2KuaZ3IHhR6qdv1GbYN73u4YUmpER8TRMhosoHsfyhmHd4zUIWOv418XrN+jExe6E
         ksWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FvWDhWISpGn4NECKTMbbAGhGOgcSHURkbEnrDvJMLos=;
        b=tGwb/sX/bUmNLxH4OfTzZcYxYmgd1wq5YUfIYTpfQQpj81BDxwK6GOeU4rt37DgEzV
         VevGZcNhtHS5Pb3zZZV1amAeG+dFVp6sXMTHY3fZVva7OMV2li6pLveGb5fJq5TiUNFt
         CgBRifVyFb+bI0VVudVtdsRvv9K6b0umvu/GeK1r7rcO/CEpGdTyDgl1tEhqbWpys+Go
         01asEaE8zQRMSKNs23Mf01ZcLvFB5I9cEZ3WAj6EJe4ug+xtddvivcLeYvLobdC3FXsT
         D8QusCkaNZChUr2tS+alSTnw7ZzNL09lqQgzKTeQDqmyDOtKj3dYhqTT92c+z9gxLPol
         5YCw==
X-Gm-Message-State: AGi0PuYrBOxCuGCLYKvrOSXFmZ1rpAqdcssWPAy6VQov0d7PBSA16Bvg
        2S3D2gEb3OXv5uuWFbEG19k=
X-Google-Smtp-Source: APiQypK5lrfo31xY8UUezFr4HAJ7K5iYcV+IgTMTdqw5RpA5VCYN8IlN/pUiRQPYMnHeei40rYxRqQ==
X-Received: by 2002:a5d:6688:: with SMTP id l8mr18750767wru.179.1587372183564;
        Mon, 20 Apr 2020 01:43:03 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:c546:5ea:178b:4074])
        by smtp.gmail.com with ESMTPSA id g74sm403183wme.44.2020.04.20.01.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:43:02 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v3 0/4] iio: vcnl: Add interrupts support for VCNL4010/20.
Date:   Mon, 20 Apr 2020 10:42:06 +0200
Message-Id: <20200420084210.14245-1-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Here's a v3 that is rebased on top of recent additions to the vcnl4000 driver.

Thanks,

Mathieu

Changes from v2:
* Rebase on iio testing branch.
* Remove useless test in vcnl4010_probe_trigger.

Changes from v1:
* Split into four different patches.
* Use iio_device_claim_direct_mode to protect
raw access from buffer capture.
* Requesting a sampling frequency above the limit is no longer possible.
* Inline read_isr and write_isr functions.
* Remove IIO_LIGHT data from buffer capture.
* Make sure postenable and predisable functions respect the common form.
* Do not set the trigger by default.
* Remove the devm_iio_triggered_buffer_setup top half.

Mathieu Othacehe (4):
  iio: vcnl4000: Factorize data reading and writing.
  iio: vcnl4000: Add event support for VCNL4010/20.
  iio: vcnl4000: Add sampling frequency support for VCNL4010/20.
  iio: vcnl4000: Add buffer support for VCNL4010/20.

 drivers/iio/light/Kconfig    |   2 +
 drivers/iio/light/vcnl4000.c | 890 ++++++++++++++++++++++++++++++++---
 2 files changed, 828 insertions(+), 64 deletions(-)

-- 
2.26.0

