Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14534354209
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 14:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbhDEMcW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 5 Apr 2021 08:32:22 -0400
Received: from p3plsmtpa06-06.prod.phx3.secureserver.net ([173.201.192.107]:50426
        "EHLO p3plsmtpa06-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232650AbhDEMcV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Apr 2021 08:32:21 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Apr 2021 08:32:21 EDT
Received: from mail-vs1-f42.google.com ([209.85.217.42])
        by :SMTPAUTH: with ESMTPSA
        id TOHplrJ1ZEYmdTOHplOanR; Mon, 05 Apr 2021 05:24:57 -0700
X-CMAE-Analysis: v=2.4 cv=adukITkt c=1 sm=1 tr=0 ts=606b0199
 a=009Z90vDMkrtyQNGSNfQpg==:117 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=3YhXtTcJ-WEA:10 a=pFd2Zl5z2vwA:10 a=ZZnuYtJkoWoA:10 a=pGLkceISAAAA:8
 a=4RBUngkUAAAA:8 a=1XWaLZrsAAAA:8 a=VDxRAwm8vqx6A6xO54EA:9 a=QEXdDO2ut3YA:10
 a=cDyXFGGuxjcA:10 a=_sbA2Q-Kp09kWB8D3iXc:22
X-SECURESERVER-ACCT: vthakkar@vaishalithakkar.in
Received: by mail-vs1-f42.google.com with SMTP id l8so5912608vsj.13;
        Mon, 05 Apr 2021 05:24:57 -0700 (PDT)
X-Gm-Message-State: AOAM531djBvdaIAk/Uf/wke303rALMxNHEUFHSAurKQw9Z1Deh0aeb8h
        FjIXbUkOiCOInwrsTmxAAV8cvQjkbO5BnwEdLsA=
X-Google-Smtp-Source: ABdhPJw8oNhc2iZlao2rYtRTr1BJxos5bPsxvxGtCHAuOUol3rpcVoj9IR6OgSIea8rGAxxX1A3+mUUu4xd3wfLvx+w=
X-Received: by 2002:a05:6102:2e5:: with SMTP id j5mr13469215vsj.38.1617625497136;
 Mon, 05 Apr 2021 05:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <YGo8q4R5dqgtDMlg@fedora>
In-Reply-To: <YGo8q4R5dqgtDMlg@fedora>
From:   Vaishali Thakkar <vthakkar@vaishalithakkar.in>
Date:   Mon, 5 Apr 2021 14:24:44 +0200
X-Gmail-Original-Message-ID: <CAK-LDb+Sdd3ubX-Mv-pPcnkrBPp_Q0_O=D4dq+b75LiSUfJrqg@mail.gmail.com>
Message-ID: <CAK-LDb+Sdd3ubX-Mv-pPcnkrBPp_Q0_O=D4dq+b75LiSUfJrqg@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: cdc: remove repeated word
To:     =?UTF-8?Q?David_Villasana_Jim=C3=A9nez?= 
        <davidvillasana14@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Outreachy <outreachy-kernel@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-CMAE-Envelope: MS4xfOb8VBbDQB4UftbWhSM1QA2ySdl/F0E70+MTX5+6Zfc9/1wPqu1jaYxg4WTI8ALi752NB64RZhAU5NdhY8RJANNiNn8ThtGGjZoUHE6Zpl0VLgNxWzCD
 6XUmNQcl0KHl0ODtziz1B5wxBNSCVHdpMs9csSNYDel9RQNpaLt2T/O9PWyEP2LAdh597YM4+Kz8CJln1OO26a2YQOu9g/TNFlP4SxOyOIZtrYeUSOKlDIcS
 ECyGHxb+2+WU1p3DLQXDSjUMVpQiOuovfAs9gYS1BEw=
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 5, 2021 at 12:24 AM David Villasana Jiménez
<davidvillasana14@gmail.com> wrote:
>
> Fix checkpatch warning:
> WARNING: Possible repeated word: 'from'

You don't need to include the checkpatch warning in the commit log.
Your commit log should just be able to give enough information about
why you're doing this change. Then you can give credit to the tool by
adding a line like this:  'Issue found by checkpatch.pl'.

> Signed-off-by: David Villasana Jiménez <davidvillasana14@gmail.com>
> ---
>  drivers/staging/iio/cdc/ad7150.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 48132ab157ef..1be214512ff8 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -57,7 +57,7 @@
>   * @threshold: thresholds for simple capacitance value events
>   * @thresh_sensitivity: threshold for simple capacitance offset
>   *     from 'average' value.
> - * @mag_sensitity: threshold for magnitude of capacitance offset from
> + * @mag_sensitity: threshold for magnitude of capacitance offset
>   *     from 'average' value.
>   * @thresh_timeout: a timeout, in samples from the moment an
>   *     adaptive threshold event occurs to when the average
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/YGo8q4R5dqgtDMlg%40fedora.



-- 
Vaishali
