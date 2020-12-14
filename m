Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3446F2DA2F9
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 23:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438982AbgLNWFp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 17:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438964AbgLNWFd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Dec 2020 17:05:33 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A1DC06179C
        for <linux-iio@vger.kernel.org>; Mon, 14 Dec 2020 14:04:53 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r7so17930529wrc.5
        for <linux-iio@vger.kernel.org>; Mon, 14 Dec 2020 14:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SJ8w9e55v1NV3R6YYsDvUAW+4anA4sCo6rNS/Pm4938=;
        b=hGUwBVWIuDLQnRR3221elon7FQ/IW3Kw/6XbK8+JgekFeHIrJWGctmK+9YUyfFA4VZ
         0G8YrxQ/exBjt4jrxVeB3fgJDfmyg3p9MSEP8/gu/tmLyx7HsaxlbsZOhr1AUIR6fDOI
         vndmykl5HQMbRwyK+Zqu2BotnghcAsCWFc9Tz0UgIpVG0aNx7xXHZ8GNfwBOPCxLxGRe
         VV3ZWujXhTCHcHIVL4Zm0juy/LIa9l6eImLLATB73T9UePsbUh1dMQneDRJN/RdmDfvL
         QwaHkfCOoG+59jh5sWaCEbcvdX1QFnzsPR6zczSABqPIIrRUoZRYv7bg21prsR2HUwyW
         oDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SJ8w9e55v1NV3R6YYsDvUAW+4anA4sCo6rNS/Pm4938=;
        b=BCnN3j43OLyWdA65Got1nfnQGtoXjzbb11lp37AQ+DW0mFoKQZkByHzjesS/YFg6/b
         DyJlK87MBPDdx+0uhBoQYGY0vu8DMEQd/Utuz0CDMg5Aatg+RRcD0XWL3cc05/FcwBBh
         D0N0m1oN6PU56Mfo+aaNYpkJs0Z4XLzffzAD2EMGt2fybG4smPYLlAXlySRh1+c7eCRB
         2b0fTOG7Z94g2XmzW7EosfYHoXQI2f9lLPT4alZHpADNHlSMSzXICYj+3/G+aoaKlptI
         YcZ9T6u4eH/CdIl6cMNU7v9Fu9cQ62fY0jWlY2QOJe+56xUDXovbH87HU/2sKQDcRAa3
         Zx4Q==
X-Gm-Message-State: AOAM530BjDdhmciKhBilSVBfNl7o6S2Br8V7FI1wuxt0LEUjGBb8nt3w
        2SJAnqNu7MRgD9TPjcvBOLW/Sg==
X-Google-Smtp-Source: ABdhPJw96+KirAnt4MKvl0nELdVN6TEAi0kN5xCKxUvGLVrKjOEywNj49TfgXyds2DjxXCB5H9iiAA==
X-Received: by 2002:adf:ffc8:: with SMTP id x8mr30773226wrs.158.1607983491919;
        Mon, 14 Dec 2020 14:04:51 -0800 (PST)
Received: from localhost (91-139-165-243.sf.ddns.bulsat.com. [91.139.165.243])
        by smtp.gmail.com with ESMTPSA id l1sm33637314wrq.64.2020.12.14.14.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 14:04:50 -0800 (PST)
From:   Slaveyko Slaveykov <sis@melexis.com>
To:     Jonathan.Cameron@huawei.com, cmo@melexis.com
Cc:     linux-iio@vger.kernel.org, andy.shevchenko@gmail.com,
        lars@metafoo.de, Slaveyko Slaveykov <sis@melexis.com>
Subject: [PATCH v4 0/1] Add delay after the addressed reset command in mlx90632.c
Date:   Tue, 15 Dec 2020 00:04:11 +0200
Message-Id: <20201214220412.13224-1-sis@melexis.com>
X-Mailer: git-send-email 2.16.2.windows.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Using the appropriate usleep_range() and stylefixing based on the 
remarks made by Lars-Peter Clausen <lars@metafoo.de>

Slaveyko Slaveykov (1):
  drivers: iio: temperature: Add delay after the addressed reset command
    in mlx90632.c

 drivers/iio/temperature/mlx90632.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.16.2.windows.1

