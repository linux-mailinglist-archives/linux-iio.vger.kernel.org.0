Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 365CC2253E
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 23:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfERVfT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 17:35:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46811 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfERVfS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 17:35:18 -0400
Received: by mail-qk1-f196.google.com with SMTP id a132so6567450qkb.13
        for <linux-iio@vger.kernel.org>; Sat, 18 May 2019 14:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YfANJ0NjSuT03hGxYrrybmRloobQ2aNV6k4ZVS8sjkk=;
        b=afVQrH7Xz2a3XaYRj2EcNEOI1KliTo4373wrA8RqskUkwhpp/S/zaAhEugOgFiu4eh
         MY0oAASE4aq5CXpHsoJeyhFiXxPl+eFazwLQU5XZ7j2s4gzqI4Io/KDeJU3WVElPvENG
         zw4dQL0mcl3IgQvxKAMj7IUcK3ssvmH+JlQUWcAEUq187N2OpSgGyzOelTTlzRC7ap1b
         5UuAwviYFGG5hh2pACCIWF8bIkJdt4XQnpceFnHChu7Ng9kXy2X20VHpKdj6afAW0kT3
         HkaFnpdxgXY3GZjSfNQD8tlTk6Ui0oqS50QVmU2v2pnHJAfRdvXmQhqFlDyCuO8i2wBb
         JhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YfANJ0NjSuT03hGxYrrybmRloobQ2aNV6k4ZVS8sjkk=;
        b=d7ba7Yguk+eUnTPs/GV+PqZQt598Q58D7lYvN/st5pMli4sXQkL2RvWbB+R9fZeT19
         pEvxUD36Gs8vYxh4B6joOi8ica8fQB2na6hzX9rqtEiY6OSSW4b8bFPvzw5BSOWrCoBP
         jFdOMoIGb88X+vJJ8G8F52pnX4RvaD4BKBDWjNxIIJ+W4rWxaK0sJUSrIebwnnAmrCnF
         3iMDcAlifE/DxJvAoGnjA9s3PXQdPW4Ob5DaVyVHzuJU5hl94+tz70qnaHKUtSHxkpJZ
         8WdOSbcAiT12Q8uuMHP6QR7DcDwlpQtlV6YKhM8PoSlG4bR26gYYGTlJLmjHSgPulIZ1
         LdTA==
X-Gm-Message-State: APjAAAXjKYBQLqqLOS7GvBzcpNLfo9S0X9jqiLHlXlzbf3ewAjKjllEB
        jJcFPy9LPRbCCOn5p/2vod/PdPa+Npw=
X-Google-Smtp-Source: APXvYqzlZ5E6k8ZLklMdQh8QfvWFADE6l2VeHowYvETh4p2a8kg0xNj0DtXAFAu5j2pPM2f3rhAXqQ==
X-Received: by 2002:a05:620a:131b:: with SMTP id o27mr23774271qkj.115.1558215317642;
        Sat, 18 May 2019 14:35:17 -0700 (PDT)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e133sm3168333qkb.76.2019.05.18.14.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 14:35:16 -0700 (PDT)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
Subject: [PATCH 0/2] Enhance dt support and channel creation
Date:   Sat, 18 May 2019 18:35:09 -0300
Message-Id: <20190518213511.23253-1-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.22.0.rc0.1.g337bb99195.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series of patches set a struct of_device_id with all the devices this
driver is able to manage and also add a macro to facilitate channel creation for
its two capacitance channels.

Bárbara Fernandes (2):
  staging: iio: cdc: ad7150: create of_device_id array
  staging: iio: cdc: ad7150: create macro for capacitance channels

 drivers/staging/iio/cdc/ad7150.c | 39 ++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 17 deletions(-)

-- 
2.22.0.rc0.1.g337bb99195.dirty

