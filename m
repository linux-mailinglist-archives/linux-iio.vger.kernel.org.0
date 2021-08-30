Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6FC3FBB27
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 19:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbhH3RmU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 13:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbhH3RmT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2021 13:42:19 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9770AC061575;
        Mon, 30 Aug 2021 10:41:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p38so32960318lfa.0;
        Mon, 30 Aug 2021 10:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZOE6NdYi7YGPVoRW2vvmAPerIza6xFYslQzFR4ZBtE=;
        b=AB1J0NmrLstVowEAiKWurJRlP2pbZhAKNC40qWhnjtDw4U6fogsrSQx7sxPXkxeL8h
         KqJ6C2h3gCdVs0ZMr+kwQATPZaUtTEiWvwcm4U9+lpVKTJqv6/BdUlnaD86nl6S0LmB2
         YKuZTGLZKCTq0UlhzS6QyieGeh6QufxKVjlw3lSot6Ngg4Oj3U45ZL9ktQdNPQRxjoSg
         SXklBgCtTxh0L9gSmMFbKJjC23VOyDVJMBHNOPYVhdJTRxlqZ7d7ptwVKu5IwB+6TRi2
         NhFHUnyyxdBbD4oY76M49syF2N0ZGf8Ry03BKJJoH9+62hgL1+CcPcunW44zEOcRcA3t
         y5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZOE6NdYi7YGPVoRW2vvmAPerIza6xFYslQzFR4ZBtE=;
        b=EACxsn3acJkquPPjE6WvbVKnF3ldH9P6qY0C3G+uZLBtejZ6JATpJQ1Jvhvufuc06K
         z1P+q9344GTUkuPyCCh/yz5NJGnX5lghOTra43ihxneSEn6hwPCiB1ZRZkZ5OXUkTOjj
         4fz/yrGhYK8X1WO8bpuC/KnmuMATnrbfavLnBbBxUe/2DV67XgvFqAHRygYc7AJ9UrJT
         +WfuiYiuhhiGW+oh1L6N6m/5xObws7Np2DefZ54jFXR7Uy3ig69dz+0/yT1bsga+IDTF
         MDaX+Mc/Clo3jP6GPy2F7yeB+GBPovsoFzJ1g8Me1PDU+cypFmu1BGBHFFMCICviIXMP
         NECg==
X-Gm-Message-State: AOAM531p0CtyesXbC4mxe2g3CqSzJD5SoZJ6jIu3pFvZKjJP9Atwr9fS
        8KuRHs3YfuMiyF+y91s2pk/pjFJDHYsVPZ6lOwo=
X-Google-Smtp-Source: ABdhPJxPCpk3CIRP6sbIr9jWcESA/cBvGxq9HPNlVRkhIW40nQT4VjSrn/CKh1mxsXM2ZRlXzyTBswE0UPmiBD7253o=
X-Received: by 2002:a19:5f0d:: with SMTP id t13mr17970186lfb.229.1630345283860;
 Mon, 30 Aug 2021 10:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210830172140.414-1-caihuoqing@baidu.com> <20210830172140.414-2-caihuoqing@baidu.com>
In-Reply-To: <20210830172140.414-2-caihuoqing@baidu.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 30 Aug 2021 14:41:12 -0300
Message-ID: <CAOMZO5CG_NtGC3ZJv+qy2YOk-J6gLyZpUMty+jna3v4V6DfmnQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] iio: adc: Init the driver for NXP i.MX8QuadXPlus
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, alex.dewar90@gmail.com,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Cai,

On Mon, Aug 30, 2021 at 2:22 PM Cai Huoqing <caihuoqing@baidu.com> wrote:

> +static int imx8qxp_adc_probe(struct platform_device *pdev)
> +{
> +       return 0;
> +}

This is not the correct way to split the series.

Patches 1, 2, 3, and 5 could be squashed into a single patch.

Thanks
