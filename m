Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDAC29C9CE
	for <lists+linux-iio@lfdr.de>; Tue, 27 Oct 2020 21:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372732AbgJ0ULp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Oct 2020 16:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35011 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S372729AbgJ0ULo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Oct 2020 16:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603829503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=lt6MI9lyzWRQsxhjflylYnJ4QKAMKvBFCYdtvU/Wi4k=;
        b=YwJaOrZbg+LBZg2G4943roIiPsycAPPIahC+ePNKvvrDOnhpVSJOkjMK7faim1UciOXp30
        w02r6F/oViCcYwhgdR+PGAZPtoWvjCUjheVW076/MRT+KnUeM2b9noy0hFm+DESkWu/VQy
        SYo2TZNszr21c7cj1gVMtcdI8FXoJYQ=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-TLZTUxW2Pl6mtHg4keznYA-1; Tue, 27 Oct 2020 16:11:42 -0400
X-MC-Unique: TLZTUxW2Pl6mtHg4keznYA-1
Received: by mail-ot1-f69.google.com with SMTP id g51so835625otg.9
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2020 13:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lt6MI9lyzWRQsxhjflylYnJ4QKAMKvBFCYdtvU/Wi4k=;
        b=jdBZuabRyS4P6OO/kAOzdOmELFDFmd112EDHHSnmh+IqUDiD3Fz6896igvubX4JKkp
         UV2kk3OYnOojAiT1iAlcE4WOEwp3N9lP/9ZfDkGPiOIAPixLHAOZwsdh0HGLz1QTSgo8
         c/UDZo9USnJBuKHq1FYNcVh+DnsmardPqSSIDlnEhwc+L4d6adIIZ6WIIIArFhBJxInv
         jIB1GxHUYvs1v4DvJ5D8yF+Z9rzBpEPyAQVkGZYRMYFJVmE/yq8sDAxKVEB1+2Xg0YVx
         LNx7C2AqlMAcSW7PcxqLQe/MYU/l5x/DS1qbR4NvzVOs6F6gvTnVPpDa52+P7u2qr3Nr
         Jf6g==
X-Gm-Message-State: AOAM53132ng3wr5zKbLlPnuj15EJGoXigZll12CWck0rhff6i4QPYR48
        LoMJ8g8GNmjEYlCivT2McpG0XvTeO5x34FFj9QBNL+P9n0iA9/PsjNAgS0cKm5g+v7XDTvN9JNt
        YaURHvW5zqphKaH7mdcn3
X-Received: by 2002:a9d:2f09:: with SMTP id h9mr2747419otb.186.1603829501207;
        Tue, 27 Oct 2020 13:11:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc0SFqKRZ753fViQfz8Ms1OZtjfHdVFd98OZflO1c8SHIGNz3TNx9l2WhvvKu/YMKZORnLDQ==
X-Received: by 2002:a9d:2f09:: with SMTP id h9mr2747408otb.186.1603829501002;
        Tue, 27 Oct 2020 13:11:41 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q139sm1940445oic.38.2020.10.27.13.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:11:40 -0700 (PDT)
From:   trix@redhat.com
To:     paul@crapouillou.net, jic23@kernel.org, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio/adc: ingenic: remove unneeded semicolon
Date:   Tue, 27 Oct 2020 13:11:28 -0700
Message-Id: <20201027201128.1597230-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/adc/ingenic-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 92b25083e23f..7886cdca5a5e 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -542,7 +542,7 @@ static int ingenic_adc_read_avail(struct iio_dev *iio_dev,
 		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
-	};
+	}
 }
 
 static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
-- 
2.18.1

