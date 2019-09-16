Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77159B40C1
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 21:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbfIPTBG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 15:01:06 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:33873 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPTBG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 15:01:06 -0400
Received: by mail-lj1-f173.google.com with SMTP id h2so1018977ljk.1;
        Mon, 16 Sep 2019 12:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6CqMFQfPPzik6PBJ5QbPlwlrkMAtMbIFqzUMAsYQhzE=;
        b=QRTDgkj/POnK8eFxO3R6Py0sADJBTC9U6j+eab0KHaDz3Gapsqc0sFSNF17m723GFc
         F6SVrFxvXaL2ryKbe4Jh3kVCISQxmllpiTxhQ7Q8gempqIOa3M5UNpTaxs6c2sJ8Q/6e
         wZW2Lsf3mQOfDU7y70Fdn+84QCPsiW7y7X4U3TrbVS5eE5lJpb+L0uQglF+UvLcTOGn2
         oAQTIlcsJBE2QIYmDLq7IV220wwFZAl+jPbwKUSgdcD9CxPTPCHLPYe1hYG3CObEwTCu
         KL7/GWV4K6CieMbXNyRmnYJmz8San+auJF/mVXMswrchL+PrBKAH+4qGqkEDo6K2F3Di
         xjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6CqMFQfPPzik6PBJ5QbPlwlrkMAtMbIFqzUMAsYQhzE=;
        b=AGf/xi1fB37euohL14KpAUBcsJ0JMeIn8MircT3X77obd2R1GMSIL4bK19dvR+giH2
         m9t0JIAN52jHyWjsRyAkiuwyvQ/FMpwriKQGnAkhMaBs2bISJA90YT6MvxS1+AvEWaTj
         yEdpwtb2ng+Om5m9IW5i3yABqo9WqldFb3refAhTXfBNXyIlc++G4QUCY/TRTtDNY+J2
         cKAjAgd9eNyACj1mBivT4F7cIBBcZIvHRYsn6kGN8WaYiol0oNVPViBVj2WaZ4KxBTvQ
         VTaXvnEqotaMhGMDQb+pBNljv+ZmTCRPzn0o0LK/+NDYdOopHAxB1M/gshCfEWB5MSzU
         5bFg==
X-Gm-Message-State: APjAAAXVzWt99wuSQN5BbechhtDJs9d5DL7cc7VeYiFVcdi3FiwDSznm
        3vkLXyKCvY+ORcMp+jpxsHamaIT4U4A=
X-Google-Smtp-Source: APXvYqxO/r0hIUkSsLV5ZzgWYqmxDxOQ8w0ApXGJNx1us6E0OUNEpi3F9kZXQsToyP+Doq4/6jnf5w==
X-Received: by 2002:a2e:958c:: with SMTP id w12mr590771ljh.98.1568660462791;
        Mon, 16 Sep 2019 12:01:02 -0700 (PDT)
Received: from arch.lan (89-70-31-203.dynamic.chello.pl. [89.70.31.203])
        by smtp.gmail.com with ESMTPSA id z9sm8414053ljn.78.2019.09.16.12.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 12:01:01 -0700 (PDT)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 0/2] iio: light: bh1750: convert bindings to yaml
Date:   Mon, 16 Sep 2019 21:00:22 +0200
Message-Id: <20190916190024.9955-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert ROHM BH1750 ambient light sensor bindings to yaml
format and while at it add myself as a driver maintainer.

Tomasz Duszynski (2):
  dt-bindings: iio: light: bh1750: convert bindings to yaml
  MAINTAINERS: add entry for ROHM BH1750 driver

 .../devicetree/bindings/iio/light/bh1750.txt  | 18 --------
 .../devicetree/bindings/iio/light/bh1750.yaml | 43 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 3 files changed, 49 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.yaml

--
2.23.0

