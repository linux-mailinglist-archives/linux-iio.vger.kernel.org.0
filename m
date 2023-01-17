Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6272566DAC5
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 11:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbjAQKTi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 05:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbjAQKTh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 05:19:37 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EC310F3
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 02:19:36 -0800 (PST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 216843F763
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 10:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1673950774;
        bh=9oqJ3n3j6fLUHt4tgp8KQk2foeHWGNvMHPDF2ID58+Q=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=DakJGCzBbXhE6v40u0xB4PLsaJrXDpPtUW8j2Tudno+JDoBR2kQdZD06E7G3q/BFe
         7O+s4LHDBiWm6R7BUACF8HdfBINi0S+1GGWG2+Yog23iWzkjDM9PY5k/hcXWU2Js/f
         06uQy1iCJbPK74gRZbqwaM8rPyIhCFJ9grw0dWRlyJDRnEvDla13bg9scvs4P0kzSV
         4Ncp48BPW3pl32zor8FNiJHcQZksQ3A5AZBZWGDMDX+5lwmvhUzruHGarQ/Czx3DEw
         xwYrQA/WQWjqUOlT6L+JvuL36zGXUCKs613E9+Yn9kDxsOAkXER3Y14RdZx6V21wJQ
         XZyos/rBbtciA==
Received: by mail-pl1-f200.google.com with SMTP id i1-20020a170902c94100b0019486e621d8so5032054pla.22
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 02:19:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oqJ3n3j6fLUHt4tgp8KQk2foeHWGNvMHPDF2ID58+Q=;
        b=ytmenLDxKZt9k18ZdKgOPmZ+TSpogetZRw+0nvRi7bPJPHvj4c1RpqxK+9qoMXs+LG
         b/uMPpCKRXhoN00H4MYYg7+gAsAlBn9LtGE/7fqEvSCsuI3TFSF+m1B0eVELu8vZsCjX
         R16e5iQ7imCjHMIrZREwzQX1SG1KTwqfu6szorT//f9YzWRpiE9R3eQdXpi926g/tUig
         VqLr4Dn9FRZa+dORUxxy0aDen7DiHugkVcrmJGFI7x22Udr2cG/SQj0jGXxscguEZ0ze
         VIi/MNHTzAwdJbHaJPO8KM7TSU/xsgNiJ4o6sTVS+eryr72MrishyIZTMfvqGbXVATb9
         TOfg==
X-Gm-Message-State: AFqh2kqHnpKgwXS6IYAq/MT8OpR7UolsZwDRUdclQCGsM73WEq+8YHza
        sGEJijbHMq6DxOblFEYmKEeuu87lOpz9YBw+OShfAskSu2vgRHJ2ONZeV6IvSltqlAw0CONvytr
        lNgxAfM3+4Mz/sQJ2rXev34+NLiF55Lkm+IgmknLBf2QjBvqf0RzboQ==
X-Received: by 2002:a62:e317:0:b0:588:cb81:9221 with SMTP id g23-20020a62e317000000b00588cb819221mr238163pfh.69.1673950770447;
        Tue, 17 Jan 2023 02:19:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsYB0UK4jfVE6hqIJsghfYcMmD0ojpo/E91LqrS705XudhX7Hpryik5KooGP0L3kIYPtC/+9AJB53aC65SbPdc=
X-Received: by 2002:a62:e317:0:b0:588:cb81:9221 with SMTP id
 g23-20020a62e317000000b00588cb819221mr238159pfh.69.1673950770084; Tue, 17 Jan
 2023 02:19:30 -0800 (PST)
MIME-Version: 1.0
References: <k0IjFnlIUFDGe3OlkvevaSjhOZclaX1X6Sskt5vhLQIv9_WeRYNZ--2gUYu67qsxY9WNu1DnH6h4lIx1UPnG4vAY4j7KuqVlq52RN0lC9dg=@protonmail.com>
 <20230103112629.000063e8@Huawei.com> <XRVRm0eZvITN7LSrbXQuiYw0sb7W0e2rdRLWGQ-9vkmrMqMVB6IMsOyxuP_CyqmUrqzHdQCASMo9_eU7N3EEkLcAvoWr716p0ZvKfdv1OmA=@protonmail.com>
 <CAAd53p6vT38y0UVMYuE3V4q07gk0wA=e18x9k3ATu_EvXWB8rA@mail.gmail.com>
 <8sH16OwIJbnTXpjBaNVGn7Qpv1HmPww_fiXBQ2EfhLkhjWnf90kGxXKfHhyZX9Eu2JqsozqOFWEk3smuGqYxkSZNxEPHTkTTjBc2n7ksRhw=@protonmail.com>
 <20230108124654.514a5b1b@jic23-huawei> <CAAd53p5nz0ehBmg05njKRG7cnBQQgJFpT-1oqDtajSY8Zz0NMw@mail.gmail.com>
 <8egyl6OawVGTgDhMmArrWCKWVTp4CxDO3jFgEMjWvk11qEyFVARwV0xoGpwBvB4CHiIVWhXth_2CKznGgCvXxFbPsrIpSwYCn_QSx4aezrk=@protonmail.com>
 <cKYeY4HN3_NekeCl1PMBnzcn-Y64OEXNKTrGyYf3wQQekbNLzQeM5TlsB1rrGlsRSjVxnGJ84CytQ0w2VhFAoAGIrYMZnvqq0XGsnyy71L8=@protonmail.com>
 <ozK9iquIv9o2or9IunOcfXJEvbVPwunC15iEe6DlT8ObOWI_wNFnJtN0lubBXEkln6pm8bp939ex7YlmEZhoxDF9nU6nKu4QkqwBkkHqJw8=@protonmail.com>
In-Reply-To: <ozK9iquIv9o2or9IunOcfXJEvbVPwunC15iEe6DlT8ObOWI_wNFnJtN0lubBXEkln6pm8bp939ex7YlmEZhoxDF9nU6nKu4QkqwBkkHqJw8=@protonmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 17 Jan 2023 18:19:18 +0800
Message-ID: <CAAd53p6ZRr5_FGgdEki+GA0FTJZ7q8g0epcH8BT_XEMUO42EHQ@mail.gmail.com>
Subject: Re: CM32181 Bug Report (Linux 6.0+)
To:     Wahaj <wahajaved@protonmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Jonathan.Cameron@huawei.com,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Wahaj,

[snipped]

> Hi Kai-Heng
>
> I have found some weird stuff going on while applying some changes. PFA a=
 patch for your reference
>
> System goes to suspend, fans immediately slow down, unlike the vanilla v6=
.x kernel, the screen doesn't wake up immediately, the fans stop spinning c=
ompletely after about 4 minutes and does not wake back up along with power =
button light on (not normal), have to force reboot after suspending
>
> Here are the jounralctl logs after closing lid
>
> - systemd[1]: Reached target Sleep.
> - systemd[1]: Starting System Suspend...
> - systemd-sleep[2150]: Entering sleep state 'suspend'...
>
> The following entry only appears after the 4 minute mark when fans shut o=
ff
>
> - kernel: PM: suspend entry (deep)
>
> I think the issue may have something to do with how the iio device is ini=
tialized. Are there any differences between the various ways of fetching th=
e i2c client from the device struct?
>
> Also, the logs do not get printed in the suspend and resume entrypoints d=
o not get printed

I think I found what went wrong. There are _two_ i2c clients for
systems with ARA.

Please give the following patch a try:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1988346/comments/53

Kai-Heng

>
>
> Best Regards
> Wahaj Javed
>
> > > > Kai-Heng
> > > >
> > > > > Jonathan
> > > > >
> > > > > > I would like to take on this bug and try to solve it if that's =
possible
> > > > > >
> > > > > > Best Regards
> > > > > > Wahaj Javed
