Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9AFABB37D
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2019 14:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfIWMRq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Sep 2019 08:17:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37076 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbfIWMRq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2019 08:17:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id f22so1916757wmc.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Sep 2019 05:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2C+RLR5w9fNyscbcJOcbN4xYi94KGcWoHnGcJ6fgR1g=;
        b=J4f2XQe3q9qyse+upzsMJ/sy1LTtYHZdAL1af7Hyv+uT+qBbXW+/DwSxwOpDh2GZA9
         HWGpH9z8LLd2zKR+q/QylFRB+2nMO2y4HolgjAGQJHURPBP5Bt/hUuoeMSIFNDiGjaqP
         yjm7wJSqqkYI7GzqwGBO61tK6KQDBM/h3bZVh/QickFmtPWV68hVZkY0kjBy33PIPcsY
         sBwxzJ0QRWjRUUbJBfuPsRmrAi3e9gRYvQxSujPtjQG5g3g4FVe/UpJQ+z5UAMWWhUmR
         3gUs1BnQ4s/iXWqI0n4KribAC3Y03lmqZZIHdfE+V5vYGTSRIgHwMaFT/MOt0P7xa6RL
         Xr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2C+RLR5w9fNyscbcJOcbN4xYi94KGcWoHnGcJ6fgR1g=;
        b=MCwVVDG6Vr0gmo6oaycdgEiigznepMdc9cxTeYuGptbTfQuS4dqquz+6eL6mPj6vAT
         lYWh1YBRj7JFk0cEtxjNr3Oh6bvGUG7zVwfVBPsl5gEHqzgp3lRcoYEumBLjZC90zaE3
         AKFe2Mkrq6VlKvOxqE4AgVanshl65MEk57hhnY7nYngA0dxTbC+pzumBAc49jw0+m/Uq
         nCFgEz7c2v2ISr+S/aBTT0YzUB6Czm1LgozJ0SsGDqrZ03HlGQfGTJIlQxaH50yl9WPs
         Vd4CDdNx1BjbMv2fwuTGsejQRhRNms/ziAO+fNvTCZHr6AxgxZgfyke3EfPwBnNe2ont
         6kWA==
X-Gm-Message-State: APjAAAXFLKf0XEnRpOERJ31KOvyAvVeOUJAm36TG1Lp0ohS6pzxyPzX8
        RKQJ1vUjH87T9wN3POzEn+8=
X-Google-Smtp-Source: APXvYqw7znlDLOglUzqEX6QA1z1yBYd6BPXaD8x5O21PV2bF3b1/h+gyXscn2y7QiAb5F1oTwqpAAg==
X-Received: by 2002:a05:600c:284:: with SMTP id 4mr13026252wmk.107.1569241064631;
        Mon, 23 Sep 2019 05:17:44 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id a7sm11342836wra.43.2019.09.23.05.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 05:17:43 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, patrick.havelange@essensium.com,
        paresh.chaudhary@rockwellcollins.com, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, matthew.weber@rockwellcollins.com
Cc:     colin.king@canonical.com, linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 0/3] iio: max31856: provide more configuration options
Date:   Mon, 23 Sep 2019 14:17:11 +0200
Message-Id: <20190923121714.13672-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series makes it possible to configure some HW features at
runtime by introducing new IIO device attributes.

Two hardware features (power mains noise rejection and HW averaging)
were not previously configurable, and one (thermocouple type selection)
was only possible via DT, but in my experience this is quite limiting in
several scenario (see 3/3 commit message for complete explanation).

These patches have been tested backporting the driver on a 4.9 upstream
kernel (Xilinx mpsoc-based board), and then rebased on the IIO testing git
tree.

Andrea Merello (3):
  iio: max31856: add option for setting mains filter rejection frequency
  iio: max31856: add support for configuring the HW averaging
  iio: max31856: add support for runtime-configuring the thermocouple
    type

 drivers/iio/temperature/max31856.c | 136 +++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

--
2.17.1
