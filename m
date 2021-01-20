Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E232FCF10
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jan 2021 12:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbhATLSY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Jan 2021 06:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731620AbhATJm2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jan 2021 04:42:28 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD11C061575
        for <linux-iio@vger.kernel.org>; Wed, 20 Jan 2021 01:41:45 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id x23so25248117lji.7
        for <linux-iio@vger.kernel.org>; Wed, 20 Jan 2021 01:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=V1UUJ9mthkBuDTCRLSsaBCt3R+PLpRTVkRcCbj3R+9k=;
        b=IXZWBXlS6fUqcR7VA5h+ToYPgjl4HA/UICB/jL84uhc2arKfFoHc68vE/IYYL3at63
         JBOXEK0E/16/Lk+uGhHtNgkttSyv0JDbXT1jx7eXc5DfUz10eo4y4+pYf6jINbTHew6s
         vlwFtGg9cJW+Y5J7IH1kwqYonOL/3tzaJeBYs/kY/O67pXwb73dnnSdMBBIzYs826vg4
         6kftBPB09l+BPtFsRpOwz7LdelYnJ61qgk/kUzjdnZSVT9yDfl9jv2E+6KQOpfjqsbv1
         /fzOZgtffR6hf3ob16uH3RcErZ64H4zjz8TWaZ3NiUQKqbf8Qc7BFG/Vg2FJvgZqv5bF
         4dcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=V1UUJ9mthkBuDTCRLSsaBCt3R+PLpRTVkRcCbj3R+9k=;
        b=nhyg7kLe7k/XU0ccpnfUUZbQpTGP8T1w8qu/oZqbjrGLvSt5BFEXLGdA4uXddaIXUH
         zxtKPYYNKlkBNo0sgSlfEyNJXPGu4EgFUxYc/WC0t9W4BqVVFPbFOC8XXxy9NUCn3dYK
         ZcTbYsTY77cjxx8abFGKIYuqt4keF3txL1u3t8Yr+PamSwkhtKzF6wLgG2l8MCUQ5Abk
         Dt8GNtWoK2PO2W7ExC70S69wpSgZgIVmUy+qB3grMPTcmVHidTpKk36movDnQ/2kzIT2
         mnfArD19B3lDQZF+FcND7ACRvpJSuorrKbG6WGdQyfF2oP0DAPeXMNBYhhe7Cr4SOsRc
         IVIw==
X-Gm-Message-State: AOAM533eX/xYmODDIQHloL82qoOETT1a4YIAVFdOJNsrh8EE8JGnngP+
        RCasME0E2JISuAgWWHxcnl25MqI7Qq9BnmwxHG4=
X-Google-Smtp-Source: ABdhPJxctsVUiGc0SxYNbQaB/ihT9kEn42DvSB+iidq1XuIVwl5D+eN8+e6xmO1AQEzre9TbHoxuMAUcIp3MwlZTwSo=
X-Received: by 2002:a2e:9a4f:: with SMTP id k15mr1876552ljj.157.1611135703616;
 Wed, 20 Jan 2021 01:41:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac2:4e4e:0:0:0:0:0 with HTTP; Wed, 20 Jan 2021 01:41:43
 -0800 (PST)
Reply-To: garnerjulianne64@gmail.com
From:   Garner Julianne <abdoufatail66@gmail.com>
Date:   Wed, 20 Jan 2021 09:41:43 +0000
Message-ID: <CAGGHBa-EGEZWF-mnwxCB3O2bmAiPT6f0VVLoFP+Yco9UQhxFrQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Frohes neues Jahr, bitte haben Sie meine vorherige E-Mail erhalten?
