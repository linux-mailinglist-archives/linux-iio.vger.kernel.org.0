Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317A63D0DD1
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 13:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbhGUKxb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jul 2021 06:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbhGUKNW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jul 2021 06:13:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05143C0613E3;
        Wed, 21 Jul 2021 03:53:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t5so1667695wrw.12;
        Wed, 21 Jul 2021 03:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzbLbux/68486Y2tXJMTmUXc6xUCOk7k8Yvz8fB3OtQ=;
        b=u0RWOSywh7VPAm139VCfl8AMSMwpzxYcLpwNKYAgCtb1tmd5GqFHwJ3RsLCa0mvz+b
         PsfwIrrhA1cea/YsXvJbfYKu0Bd+dJ4jrf/L/xVRP0zNeDrZ7uu6z09kDArFMqzv6Oi8
         HTe9tb/2/FcUJISKwn8yCqIPaKG1zObj0R141eTCtszZ+/N32mNoKyo5Tf3pHq+DLWAd
         +MFIPuMAj3IlbXTXke9SH+M7Lm2ELc0B2Ucz2TBUkV0zTSKEmQMg5PRh/R2xTmbP4dKl
         Sm4Hdlp+JvqSeDloah8saEuX3zHmECoV/iv33P+AXIvdR03WwxrlsvpjPn4HbDBJrUC/
         wOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzbLbux/68486Y2tXJMTmUXc6xUCOk7k8Yvz8fB3OtQ=;
        b=iyjuSmOdqHGTyq7dqoe206v9rDK+eT9S+PKoPd0macaQrfYQEFZU1F9HywPS/RKCtV
         FzhTRc3a6W12wfgTbbR9uPbeLPa/pALCKsI/VWAHoZWkzR8edaTBN2WQcVVvVnP18vnd
         mtANzi9jltm95ANy76HWEpYPzalx7xHC69BcJ0utdtOI37c8Zin0JQIWORdEwWcV2A3E
         RoaAgrIcSt7HXkzxWsUIiDaS2Nj7Sx56UyEPFFGFhgQMsGlPREDITb0DtMkTbQR+4Kdg
         S1ec9C2F0h4wK9sPE5B+pNB5EAaP9S0Zpov9ux0zZge/TzF5vr4uD+ch3VG+JvrZNk09
         X+yw==
X-Gm-Message-State: AOAM5309vYNjslaT1Uru5zHtseUVQ8hoXhaPXzo+4I5eVmGGBGsMj6jL
        U26oG9ZPeDgFQyYqCuNij5Cqr20UdmrcmVos
X-Google-Smtp-Source: ABdhPJwZxRabAFdGNCCNR2ghnjg4C1j340MjyvSQtM5A/lllHsQZ/zBVnk5UWNt3hC/1QAw5z7ahcg==
X-Received: by 2002:a5d:414b:: with SMTP id c11mr43118273wrq.162.1626864812507;
        Wed, 21 Jul 2021 03:53:32 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id o14sm26933641wrj.66.2021.07.21.03.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 03:53:32 -0700 (PDT)
From:   citral23 <cbranchereau@gmail.com>
To:     paul@crapouillou.net
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu
Subject: [PATCH] Ingenic: iio/adc: add JZ4760(B) support to the 
Date:   Wed, 21 Jul 2021 12:53:11 +0200
Message-Id: <20210721105317.36742-1-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a set of patches to add support for the JZ4760(B) socs
to ingenic-sadc, those socs have 3 aux channels, and the JZ4760B
has an extra register to set the battery divider as internal or 
external.


