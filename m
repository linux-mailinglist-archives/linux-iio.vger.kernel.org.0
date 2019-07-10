Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B89264CAC
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2019 21:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfGJTWb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jul 2019 15:22:31 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:34924 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfGJTWb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jul 2019 15:22:31 -0400
Received: by mail-lf1-f46.google.com with SMTP id p197so2390683lfa.2;
        Wed, 10 Jul 2019 12:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z2Uqn8KaqAt4pyqoTXJXbIy2RR8WRUZ2AX1N5WTbhWA=;
        b=j1oBImM2v6CYPEZCuqx5JvSx9EqzQn/b7nImCL79tH/QPlYvqpCUNjDdPwEuFv/h+w
         M4hXGwfvywI9Z+L2+TNoHOj1AH0r1FJ5o9gxAj6Y3eL8mxlNyP08oHRfh3k36knx/+nX
         edORECxbrNGtc6yhyBNIv6LW73LVsjenamUSwTFOZnK4DsUPaRtjdvwUOSYd7xqvXfw2
         jK/kX5MKh58E3KvS0GLDU6rdb58Jf4xgZbnpU7zm8bAqsEdSnZkntHLVZmddhEgCmlVg
         Ji6W+slznOUazBqFjbjZ3esSK2207S53fSatvqhCEG9u9IIeOOPWGIzmQ+xCThb2kIwg
         7FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z2Uqn8KaqAt4pyqoTXJXbIy2RR8WRUZ2AX1N5WTbhWA=;
        b=P6ZffLh4C8PxojKOsBAyeXqxJmIb9bE0Uw9Ok1Sg2LJZtsoKOWIBrlILfnT0qXxXxZ
         DXTpVWaSPg7LdKp9vtY/MLGc1IhpFs2u+KNlEW57eyLYWx0kQ9OqzR7sj4GLHQGVEaRd
         Zue2nkfmuRwcuR3OZTf3FqMPheITorN3JW729wHhpZvUINOMIE3dTAouN/tNp7DsBip8
         Ne57awE1fO10lmLlRkrc7mPyEeOctqg6rBYsU9WYTRzRVwfO4uPkMlFsqs33mQPf8zDh
         mZO5vgwTTrQVUR9Rc/nFJsBUgSY+48gQ31kJjKSpyjvG5nAp7CWMbaDkb8mgsB2Rmw6r
         vFTA==
X-Gm-Message-State: APjAAAUZvIlld0we987Jp5nXZS7zyvom5it8SiB2ZK+gLXrUl/qMT6xo
        vQBAFUClblsnZ2eIi3O7hj0MCQqlXXg=
X-Google-Smtp-Source: APXvYqxqDSVbdOa6febH/m2WRnsXKHZT9QvvSWZpiCOCKOmHDol6eFPb/KT8/8XyI9A1iWwQl5KE+g==
X-Received: by 2002:ac2:4202:: with SMTP id y2mr5892071lfh.178.1562786548105;
        Wed, 10 Jul 2019 12:22:28 -0700 (PDT)
Received: from arch.lan (89-70-29-67.dynamic.chello.pl. [89.70.29.67])
        by smtp.gmail.com with ESMTPSA id a70sm603515ljf.57.2019.07.10.12.22.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 12:22:27 -0700 (PDT)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 0/2] iio: chemical: pms7003: convert bindings to yaml
Date:   Wed, 10 Jul 2019 21:21:53 +0200
Message-Id: <20190710192155.11489-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert plantower pms7003 air pollution sensor bindings to yaml and
while at it add myself as a driver maintainer.

Tomasz Duszynski (2):
  dt-bindings: iio: chemical: pms7003: convert bindings to yaml
  MAINTAINERS: add entry for plantower pms7003 driver

 .../iio/chemical/plantower,pms7003.txt        | 26 ----------
 .../iio/chemical/plantower,pms7003.yaml       | 51 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 3 files changed, 57 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml

--
2.22.0

