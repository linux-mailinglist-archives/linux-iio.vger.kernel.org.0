Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65160B59F7
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 05:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfIRDGe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 23:06:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44150 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfIRDGe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 23:06:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so3111215pgl.11;
        Tue, 17 Sep 2019 20:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NFqeD5/zEvzuP1V57BQP+iJPXnvZP4oIjaBFaXSxWeA=;
        b=HcC7v5VwaYc8p+6PUDHEtjpi5pjd0SqaG8yymmVHQ7Qc38w47fpqQXBBGoWjLyqtBg
         vgWdY8stHVxsOhHW6JCwxyN+9pAOmdfBDOOPnxPTJzugaQR3jrj5NgPPHPG1UiCrck5P
         B5lZJn9azBSJJNpx/J45bwRFVkBfywsG+yZh7kD2XyqcMCPPKvc6dNyM7HBdj6EQpOV6
         ZzcRyB6qvA1QyIwuAlPeEBBR09RJo+4gCtOBA7h6xjfvj17LnUNoIylQZgPIeYsSt9Nn
         PPWkr0hQ8uby9b7aPMFnQqiDizeM++fEUdze3zqmix5CJOCPAcJWtpiq76VWL5BH+63u
         ZEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NFqeD5/zEvzuP1V57BQP+iJPXnvZP4oIjaBFaXSxWeA=;
        b=HG5Os6m6/e82pNGbJByLBGxSWLvfPB4QpGZrAzRSAw6XIEfYUx6DlSP/MMg/4jg9FT
         8ElSA+2JeAd9DNRgf6/LjaukjxTyXhpjpg8RrpJ1GNIUFvcVQpDh9htA2kybu81fFELn
         wTozDEiLTofwtcb7qv+f6PCR+TpVJzIOIL7pfjtbF9hahVc7ix7RagtZvmftYnmKEjMm
         zjAcAEdNlXD3xA+20HRbojAghuCdNHdTGkm5XdtZPiHP+wm4QDECSakNRRV5J6MOPGeL
         7CEEa+CApO2ODsJAzOVUgWwE3gheoQry2zsOYNBAV7TLNOW165IyytOZ/0idotVpRabJ
         rxeA==
X-Gm-Message-State: APjAAAUBfMJxg2b3cOCQDWnX0ZrYjebayui07JYfwHbJ10IE2vc6CE8z
        JlJAPzC+yW94d31sbSPGnZ0=
X-Google-Smtp-Source: APXvYqyOcjtk9Gxp4VKjkQDDqHIZ+4UjqQOOJRCOfPZXKU9y6/oBgSiQ2Y6I8KqB0jCErc51dDXGaA==
X-Received: by 2002:a65:60c4:: with SMTP id r4mr1891524pgv.31.1568775993844;
        Tue, 17 Sep 2019 20:06:33 -0700 (PDT)
Received: from localhost.localdomain ([106.51.108.240])
        by smtp.gmail.com with ESMTPSA id a18sm3285861pgl.44.2019.09.17.20.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 20:06:33 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Add driver for veml6030 ambient light sensor 
Date:   Wed, 18 Sep 2019 08:36:20 +0530
Message-Id: <1568775982-4682-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The veml6030 is an ambient light sensor from vishay and
is a different hardware from an existing hardware for which
driver currently exist, therefore this driver submission.

* All features; ALS, white channel and power management is
  supported.

* All configurable parameters are supported through standard
  iio sysfs entries. User space can get valid values of any
  parameter (xx_available) and then can write to appropriate
  sysfs entry.

* User space can get ALS and White channel readings through RAW
  IIO interface.

* IIO events are used to notify application whenever threshold
  is crossed. This uses IRQ pin of veml6030.

* Some registers in veml6030 are read only. For these registers
  read callback returns error to user space.

There are 2 patches for this submission:
[PATCH 1/2] iio: light: add driver for veml6030 ambient light sensor
[PATCH 2/2] dt-bindings: iio: light: add veml6030 ALS bindings

Regards,
Rishi
