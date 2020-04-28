Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF731BB5F2
	for <lists+linux-iio@lfdr.de>; Tue, 28 Apr 2020 07:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgD1Fm0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Apr 2020 01:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726042AbgD1FmZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Apr 2020 01:42:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6643C03C1AC
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2020 22:42:23 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id e25so20113118ljg.5
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2020 22:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rXfCuONKkFQErFyItyEhH+ZQDNjrMFcXvZTcGR3/lCg=;
        b=nnAHAFulypcv2+VrcXmbPBjSr5BgpaYfBlP+gyBpLbvkTfX+bjC6SOJiRAZdKzpkFG
         hSPk3eJhCJs5caEYxcEU0L75I3QBibov7hVuhAOFOOZU10/ul+qDfvjOLmF+qcfpjve7
         65VumomLIwqH7nrW1df6/CypaLZb/DW7qkCQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rXfCuONKkFQErFyItyEhH+ZQDNjrMFcXvZTcGR3/lCg=;
        b=Givzf0LFQSRKg8z0LqdJOSwya/5HIRZJ93Nijk2VTAlSjYEe+MYA0dtuCvhoWGBY37
         ZPGTrYWGZfapMqUbIQQsvVplyHCpC29D5eI9o9/htHJUWAsg9k8SjPQ+iR/9ho+yUbm8
         1mslXar5YdGpyHAAV+VR3zg0/4p4DBK0S8OL3txvwJCMMXfnv1QR3QES8qZWdU3R8RnR
         e8bTJVouaFP588Ym/0ssMezdICY3XPklMcWjJpl5uHasYr0XWpF97U8re5pl/51GK/f3
         KNvrQYfHOQAeb1cZyyLU1wJe/9sDPVylFPW72xZt814kNgrvwIgJ81JPelHD+bOo3jGJ
         pbIg==
X-Gm-Message-State: AGi0PuY42c8AxO2e/gsVknhmZwZnu1fgVcrHuyKnhNQ1HaG/xsfrQ3V4
        kaAVvwlQNzrIvlpIkANU6bJlobRppYU=
X-Google-Smtp-Source: APiQypIEHX09fqqfGezl9G4cNfxy4jkgldS+9DIP+1eLIhQi/xyvgEnlGDkYWVPTj1KXQwawY4Corw==
X-Received: by 2002:a2e:87d3:: with SMTP id v19mr15523942ljj.176.1588052540599;
        Mon, 27 Apr 2020 22:42:20 -0700 (PDT)
Received: from taos-chr.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id c4sm13240035lfg.82.2020.04.27.22.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 22:42:19 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 0/2] iio: chemical: add atlas-ezo-sensor initial support
Date:   Tue, 28 Apr 2020 08:41:05 +0300
Message-Id: <20200428054107.16061-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add driver for Alas Scientific EZO sensors with initial support for CO2
sensors.

Matt Ranostay (2):
  dt-bindings: iio: chemical: add CO2 EZO module documentation
  iio: chemical: add atlas-ezo-sensor initial support

 .../bindings/iio/chemical/atlas,sensor.yaml   |   6 +-
 drivers/iio/chemical/Kconfig                  |  11 ++
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/atlas-ezo-sensor.c       | 173 ++++++++++++++++++
 4 files changed, 189 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/chemical/atlas-ezo-sensor.c

-- 
2.20.1

