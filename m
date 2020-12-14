Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9722DA1E3
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 21:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503123AbgLNUoN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 15:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502980AbgLNUoN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Dec 2020 15:44:13 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1DDC0613D3
        for <linux-iio@vger.kernel.org>; Mon, 14 Dec 2020 12:43:32 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id i9so17774677wrc.4
        for <linux-iio@vger.kernel.org>; Mon, 14 Dec 2020 12:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wdsM3/L8vrQpXArDXim2ysu6MOaxvEPt6vk8T/4ggM8=;
        b=e6RN3XQ+yK/OHbGzV8RqfmuuigaJ1G/TvYvOX8qedYfxqZWPMWCGWZL3PS8Wk5oO+B
         MRK+O/k8fzrmDcrNM1aONG0SqOZHz0gqRkN6RLE4zoz6lCs7m5WxmZlQyhQoE6tO3TRo
         CvCyYFOqvFV5vt9Phls1lPNHkqyOf22zyyZfuuO2QDeAEBKqUvNi7XYYfZUfL+kQ3lNq
         f0e6Pgl0ud/Q8MZ4oUrulP28OyuI9oEPNNBKTa3fJKyG90LuogHq89O4yvPeIgj74TGK
         yBSjqPVtTao0EFc10Fp6dqk0r7msDCrTTw8cZbQJlql08J1y2t1Yp5pn2gHkLuR+rYxA
         o17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wdsM3/L8vrQpXArDXim2ysu6MOaxvEPt6vk8T/4ggM8=;
        b=RqDf3kGoWGfmuxqK6v8OLrdgnsL0A9s5cEbCqzJlrhcKBMDPZJ+rANBrUyMkQ3Fv1n
         H9CuxsXFKCvvSjHeAB+rxitfUWeBJ0cco0SRxEMm2sKIfnKt/Dnq6oy0mD5B2do85lrB
         Fla//jtV76Ma5RB7voDJTRrhS/WV8laNZJqRO7kdO+QZldMeKn6oH/CZbMhW5SoKfHRF
         jVQcJ/hBaVF7ml9yU+i53qvuM3K8NrkjqKh5TnsmWCWqhV7OU5W3u9+mgC0YSr4Prt9n
         4MduE4duiO7DwgZGa+wNYBeT5N2kzc5wZs2tc+WNkpMRmhGZgHhactJUTOVlS4FlH8L6
         Vn4A==
X-Gm-Message-State: AOAM532tbxCaYodpcJoEf7NzfJjk4F0Q0kojTBsuNTWXmtXluGzGgmy4
        uFY9jnnF+VG1GQjahRouRuEgfzQV0MzVjFoN
X-Google-Smtp-Source: ABdhPJyht2JysM7ENqy7lPVfYOSXQu864g88weFu/JZiGw3G1CwTCz/yunwGyKvrWGGq/lsS4SWpYA==
X-Received: by 2002:a5d:660c:: with SMTP id n12mr31232288wru.291.1607978611566;
        Mon, 14 Dec 2020 12:43:31 -0800 (PST)
Received: from localhost (91-139-165-243.sf.ddns.bulsat.com. [91.139.165.243])
        by smtp.gmail.com with ESMTPSA id f14sm35447894wme.14.2020.12.14.12.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 12:43:30 -0800 (PST)
From:   Slaveyko Slaveykov <sis@melexis.com>
To:     Jonathan.Cameron@huawei.com, cmo@melexis.com
Cc:     linux-iio@vger.kernel.org, Slaveyko Slaveykov <sis@melexis.com>
Subject: [PATCH v3 0/1] Add delay after the addressed reset command in mlx90632.c
Date:   Mon, 14 Dec 2020 22:42:40 +0200
Message-Id: <20201214204241.12308-1-sis@melexis.com>
X-Mailer: git-send-email 2.16.2.windows.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changed comment style for the delay line so that it matches the preferred 
style for multi-line comments.

Slaveyko Slaveykov (1):
  drivers: iio: temperature: Add delay after the addressed reset command
    in mlx90632.c

 drivers/iio/temperature/mlx90632.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.16.2.windows.1

