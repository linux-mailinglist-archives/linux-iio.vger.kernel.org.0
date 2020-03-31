Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD511995A6
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 13:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgCaLsE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 07:48:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34726 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgCaLsE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 07:48:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id l14so3103719pgb.1;
        Tue, 31 Mar 2020 04:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=++UQlU6VN9bMxqDPdQyUp42DcXToJ2hwFVgrDIaZHqs=;
        b=DnpeTBqmQ09ZN3NXi5SsJcWx9eJloyCTDAjUGp7W3ujRWHrEAffpirrxpGE+/5NZJ/
         PFaJh0WUYpXH8lubP3jepsiDwe0hMz5fi0RCZCk9GiB07CYck4SRY5FJSVwVZ3gPYDWZ
         utYVBnsu18+Q1bH2PTgjL1cxFv589vbgKXcjQuhg/FE2FkR47s0xQupNWYASV1JhHH8b
         f1b+3JrWQvXFvsI587ixk5ECRa4hhEduioP0U19lQPpMzFOhwUDokg6/p8mLMHwafS/p
         4REYbDxZNAczqAFQUOUiyMvCuZ5ijg1cldarm0LZeiRXGYtLviEYH5OOCzijLcg/eo23
         PIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=++UQlU6VN9bMxqDPdQyUp42DcXToJ2hwFVgrDIaZHqs=;
        b=omi3tWjsonmHucWgw/oHLjoXv0S5oodWV8l01wwmGI74xgYMdXTZ+wEO+RKoIVOUYW
         FWt9U8VVd3l9GYy8LsovCBPxZZKD4X93MEATvYTCHhhqc4JhyP1kL3O9jhATSXktKxSt
         rPRE64G0sTXBQaYU6MwzZpiqTx6KKfV3zpDNAZeagYFLN0WPnPZQN0Sgi1VAlbvrU1dm
         z0BZzBVC2uQdvPUX7KkTNHCvw4xsAJPe3ZycyOEisHTTo3rKby6ZTM+QekTdqRflqQDN
         lAyM23bRGsO+WX+azx8+McL5d5A/Hu2PhJ7mF+w6Qs/lGe45RSY/mnq7Oj/x+9YF65kz
         6bsA==
X-Gm-Message-State: AGi0Puamzqc2zcSd7ORDzQv3LfUfP4/ykWS3rr3ITzVg2A3nPpCtalzR
        ZYmqWnEmELXN+njCmFdN1uTVbc9GDzzJWQ==
X-Google-Smtp-Source: APiQypI54/hk+3/QJD7H5lyRnC0PFFEBG6sV3AsATVr65uXQv2wnXbSRfDI1h7izLDqdFA1uEAWb0w==
X-Received: by 2002:a63:7159:: with SMTP id b25mr3716022pgn.72.1585655282423;
        Tue, 31 Mar 2020 04:48:02 -0700 (PDT)
Received: from localhost.localdomain ([122.178.242.244])
        by smtp.gmail.com with ESMTPSA id i15sm11601220pgc.74.2020.03.31.04.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 04:48:01 -0700 (PDT)
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     dragos.bogdan@analog.com, Rohit Sarkar <rohitsarkar5398@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] use DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
Date:   Tue, 31 Mar 2020 17:17:29 +0530
Message-Id: <20200331114732.14739-1-rohitsarkar5398@gmail.com>
X-Mailer: git-send-email 2.23.0.385.gbc12974a89
In-Reply-To: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
References: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The debugfs_create_file_unsafe method does not protect the fops given to
it from file removal. It must be used with DEFINE_DEBUGFS_ATTRIBUTE
which makes the fops aware of the file lifetime.

Further using DEFINE_DEBUGFS_ATTRIBUTE along with
debugfs_create_file_unsafe significantly reduces the overhead introduced by
debugfs_create_file which creates a lifetime managing proxy around each
fops handed in. Refer [1] for more on this.

Fixes the following warnings reported by coccinelle:
drivers/iio/imu//adis16460.c:126:0-23: WARNING: adis16460_flash_count_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
drivers/iio/imu//adis16460.c:108:0-23: WARNING: adis16460_product_id_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
drivers/iio/imu//adis16460.c:90:0-23: WARNING: adis16460_serial_number_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
drivers/iio/imu//adis16400.c:278:0-23: WARNING: adis16400_flash_count_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
drivers/iio/imu//adis16400.c:261:0-23: WARNING: adis16400_product_id_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE

[1]: https://lists.gt.net/linux/kernel/2369498

Changelog v1 -> v2
* Use debugfs_create_file_unsafe instead of debugfs_create_file

Rohit Sarkar (2):
  iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE instead of
    DEFINE_SIMPLE_ATTRIBUTE
  iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE instead of
    DEFINE_SIMPLE_ATTRIBUTE

 drivers/iio/imu/adis16400.c | 19 ++++++++++---------
 drivers/iio/imu/adis16460.c | 27 +++++++++++++++------------
 2 files changed, 25 insertions(+), 21 deletions(-)

-- 
2.23.0.385.gbc12974a89

