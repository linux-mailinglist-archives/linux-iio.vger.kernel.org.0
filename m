Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AF93DA366
	for <lists+linux-iio@lfdr.de>; Thu, 29 Jul 2021 14:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbhG2Mxm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 29 Jul 2021 08:53:42 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:51982 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbhG2Mvl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jul 2021 08:51:41 -0400
Received: by mail-wm1-f53.google.com with SMTP id u15so3660906wmj.1
        for <linux-iio@vger.kernel.org>; Thu, 29 Jul 2021 05:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=LktD1zcvfBP4DWGQMmH10UQmo1ahyeWFPm0QmWNqjcc=;
        b=iu6pwNsGvwr04exPcjvzux1uF7/ocgI8RH4ut/ajSYI5swzpfqbwb20E0kDQ9Pqk2Y
         WwAE5/hlv8I9n5pSI5acSEwO4RjoLQ3DKARro1qMNVcayZq097IjrtNqpq+JtKCtCBZw
         2k37OlyCu/A6npo6DPj0QEelJf/bZ+MtB6Rk47pMELT66HgOG0vc7+kT/aM8wIbmkwse
         cTcPX75zuY5GrpbmvUo1lJvSTxYxfEkTwQt+KKQvENTNBriUYuG2pLNZj1b3bdjuGKFO
         KIRNb0z6j7cQpRK1tT4z7KPtTiRlXzZszeMsGPGq6XOLh48bVvB+e5icLRt6NdJDd4Ui
         DL5w==
X-Gm-Message-State: AOAM533Jpdz+7axr+meIamGb6uB4SM49W2vs1BUVOdIYMAEljzn/hnMg
        3UBFmOhXN6l23FRsBZtMLSOQh4ym3z4=
X-Google-Smtp-Source: ABdhPJyShdCqu/ZbQAecPV4UolDmWRe3YwUEvHg4fBjvlesffOwnqtwexZr8vKwXwO7H79aAkKDQ/w==
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr4666481wmq.9.1627563061884;
        Thu, 29 Jul 2021 05:51:01 -0700 (PDT)
Received: from localhost.localdomain (cpc142184-mcam2-2-0-cust140.18-3.cable.virginm.net. [82.31.129.141])
        by smtp.gmail.com with ESMTPSA id x21sm5506394wmi.46.2021.07.29.05.51.00
        for <linux-iio@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jul 2021 05:51:00 -0700 (PDT)
Received: from smtpclient.apple ([10.0.0.191])
        by localhost.localdomain (8.14.3/8.14.3/Debian-9.4) with ESMTP id 16TCUXdn025406
        for <linux-iio@vger.kernel.org>; Thu, 29 Jul 2021 13:30:34 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Patrick Regnouf <patrick@patricknet.net>
Mime-Version: 1.0 (1.0)
Date:   Thu, 29 Jul 2021 13:50:52 +0100
Subject: IRQ related query
Message-Id: <2B7BAE11-FF1D-4A3C-9E00-E3ACD280D66E@patricknet.net>
To:     linux-iio@vger.kernel.org
X-Mailer: iPhone Mail (18F72)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello, 

Please someone tell me whether this is the right mailing list to ask questions related to actually using libiio or actually please point me in the right direction

To summarise I am looking for C source code that would capture an IRQ emitted by an iio accelerometer (LSM6DSLTR) all of that using libiio 

I have successfully implemented a program that can read the x, y and z axis but that means polling constantly. Not an option…  the iio_device_set_trigger however returns “no such file or directory “ 

Thanks

/Patrick
