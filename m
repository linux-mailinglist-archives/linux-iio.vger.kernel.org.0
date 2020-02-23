Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9923C1696F3
	for <lists+linux-iio@lfdr.de>; Sun, 23 Feb 2020 10:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgBWJGR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Feb 2020 04:06:17 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:39238 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWJGQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Feb 2020 04:06:16 -0500
Received: by mail-pj1-f43.google.com with SMTP id e9so2729304pjr.4
        for <linux-iio@vger.kernel.org>; Sun, 23 Feb 2020 01:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fHCAu6BWzWw7+SchjVk5/ayrQae6BucF6ZJxZBKEH7s=;
        b=nZIyIvxprDc4z7A/3y1YEGkT2oqG4lnQhsiJUjajQvq16NJX7/0Y9baiyi8UyT+c75
         BRgIhpGjFBbBSOfHltctLqN0Fofc+5+mD8jArkGcXfmKiu0drrQmxTiFdjnvD8//DCOo
         rKkxDEPXA5mKJ1asiKWAXnnovcrv89SYzPsB3gsZCf+T8u5WX4QAlxBwrGC44FQ11anc
         g2XBgKxvnKuCMNJ3ftnIEnO1YpAlhf+rKgAAGGHukuoEoNK3S+OwS6Dw7jCOe3rWKacC
         qDAOIAiaCniORdMvFH8U8a1BtInYH9yNDP5KQS3t8bLS3sXpp3GrMjuF8i0DUfUgtqz2
         X9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fHCAu6BWzWw7+SchjVk5/ayrQae6BucF6ZJxZBKEH7s=;
        b=msfR85EMP57dx60gMCc/UXNvzG2ZFntJp8ukrzHBzu+U6E9sbUxiW6603x9QdLU1k3
         drE8LmeKJUvKUPhF9ifrMdkAx014eGkt2gt0lLlKtIg9rJm0MoZsduCFFXnBc7B8XNOq
         0AgPoRjRGs0a/bLzY80SrrhebjP2M35VC4xv98V1nHrmvljej3Hvbp7I22H1VEpiYWIk
         75vAVNjme+pTPIXZrk996jWrlzalYZ2R3Z8gL6R2Stk7nv1pgVT1PqJxV4iAyIASGTjs
         JRxDGQuavcVTeedtLkWQoyi82ZAT40hC5XjGi3/OfYin2XcE/q9imQpjdufh2Ox0if++
         VjyQ==
X-Gm-Message-State: APjAAAUeKRdaUC/DfRwBHpDv4j8YWt8VJ3xaGj5yJJlPex97Rfjf6A+K
        n4et/sGt8URmYHwRBfpx8SVm/Ne1thM=
X-Google-Smtp-Source: APXvYqzS6r8qTnPXtfbY015x5EQQv60qJnLD+AKcMErToECC3q9vJ3pUEjzU8My/GUgJvWAsSPoHwA==
X-Received: by 2002:a17:90a:868b:: with SMTP id p11mr13749960pjn.60.1582448773529;
        Sun, 23 Feb 2020 01:06:13 -0800 (PST)
Received: from SARKAR ([49.207.56.215])
        by smtp.gmail.com with ESMTPSA id k29sm8703454pfh.77.2020.02.23.01.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 01:06:12 -0800 (PST)
Date:   Sun, 23 Feb 2020 14:36:09 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     device-drivers-devel@blackfin.uclinux.org
Subject: IIO staging TODO
Message-ID: <20200223090609.GA5222@SARKAR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey,
I was going through the TODO in staging/iio.

"
Convert all uses of the old GPIO API from <linux/gpio.h> to the
GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
lines from device tree, ACPI or board files, board files should
use <linux/gpio/machine.h>.
"

I couldn't find any usages of the old gpio API in iio staging. We can
probably update the TODO to remove this item.

Was wondering if there is any other TODO/ low hanging fruit in IIO?

Thanks,
Rohit
