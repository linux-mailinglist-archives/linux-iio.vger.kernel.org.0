Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42BFD19F84E
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 16:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgDFOyF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 10:54:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35159 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgDFOyE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 10:54:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so15547630wrx.2;
        Mon, 06 Apr 2020 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GM8pmA0bF/BIQEH6kTtZ09PNq4LdZfP9ULe+mMKgM/k=;
        b=Wc0dTdPx5MzV2wj/LDuBVCbPzkyLdonQvb3lrIvj4TJwsA87LN5LfJHzMqtCrTw1D/
         V2g/WqPCePWQCHcEPsTi0Lb2mQxvIy8RyqVduiT/Gj381pwBQ/Bs6J5P0GWO4QY+Z5dm
         08uuIyIdrWdrFrNW4/N0c9xdONxWhfOUqKagC+AVFjN0tvMOgjbFhydFXmfNRFedmO7H
         NAA0doBBq8GrW/HTXrIzdBSKYC9iHLhjY0opse85oCJJARsNpth4x3uAj2lXRpUI+yTs
         dhR2uKj3CL33Jnj6l352myIOT2hq3kExa6QlebDqtwZ/j7Jjjltiv9XUdjDGvNxco4hA
         qczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GM8pmA0bF/BIQEH6kTtZ09PNq4LdZfP9ULe+mMKgM/k=;
        b=spo+nyIpsskZYqiYtxjQLDrQ54WUXrec44tYj/oDlEBVnZOocRNeyGU05ODN2+r64U
         Yu1yqgLqr1ZdsD/usGZGpHlm3Jbvjky86GPJLDJ210YMF0cEPO18CDxGZB2WL9/SsnzW
         Amrg8MFzxA19Lxv2CJ7ZSqKdrDo8NZ+DZ00O3oON/a/36ZOcaSHKsJi1CgKM+g9Y45/X
         DaIhaVaLwut3viE1udBNE1JBMrfygnrQ8ozuzTS8007aKW4tIAFf2SJ2CpBapu/yGqqG
         +W2Qe4Ysng4R68pzqipZcYqQGYKQmN2em/pr3UNr5OMA6SFhbWXGqYXGKdVeeF72Pwdk
         1Iwg==
X-Gm-Message-State: AGi0PubRkGVkcdwjNvHCjH8ROpXS2Zok/HxhhPE7a85056+7etTYi28u
        EEROFQ0kR1cOn4ZYefTajQQ=
X-Google-Smtp-Source: APiQypKxgaH8iLyioXy6Gv7ARI//mo3+aa5lemkjElutG3ckn8wXLDnpoW83ui1IJ5MTkLyiJILfOg==
X-Received: by 2002:a5d:5001:: with SMTP id e1mr4239089wrt.246.1586184842918;
        Mon, 06 Apr 2020 07:54:02 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:586b:b940:d2f2:e882])
        by smtp.gmail.com with ESMTPSA id d7sm26382914wrr.77.2020.04.06.07.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:54:02 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v2 0/4] iio: vcnl: Add interrupts support for VCNL4010/20.
Date:   Mon,  6 Apr 2020 16:53:52 +0200
Message-Id: <20200406145356.25883-1-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Thanks for reviewing Jonathan! I did split the original patch into four
parts. I should have done it in the first place, sorry about that.

I did drop the ALS data from the buffer, as they are not really useful
anyway. I also used iio_device_claim_direct_mode as requested. But making sure
buffer and event capture are not done simultaneously is quite tricky as you
mentionned.

Thanks,

Mathieu

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
 drivers/iio/light/vcnl4000.c | 856 +++++++++++++++++++++++++++++++++--
 2 files changed, 813 insertions(+), 45 deletions(-)

-- 
2.26.0

