Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49AD6194378
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 16:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgCZPrS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 11:47:18 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:50856 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgCZPrS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 11:47:18 -0400
Received: by mail-pj1-f53.google.com with SMTP id v13so2638453pjb.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2020 08:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=lsyS2VDBkMEuV9feIHFoicJ02fKd5n/m6JYDAVIiN/c=;
        b=MhY9k8WicEljMYmaoiO5ykik7SN40pMaWJ+TiKVWwpzPy2lCuMFD45ELpHBQGRAEHZ
         WVSSc2TcTbEFRifE+cm4ae65UoIz7hJU/++1ZnrYNXHVj18UYdvcDpq931eovfZMwRqy
         2AfqnU1yPp4EPxy86tBr9MprC6qAxnQLjbICp8kdkKyAXgVqw6TLyv5JWBebNQyRVa8D
         jNYdP6Oey10YTuDuSPFoBW2JcvNdVrfm53aBhQfV3eOOtz+nbdt36aNv+ZEm+xzTiTXf
         0CHY1F06WkaNJ/ipd3PnJDd23iHqoCcxGQ99ensXCBRQ1ConihCILnhlcvngluj8/SuI
         Us2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=lsyS2VDBkMEuV9feIHFoicJ02fKd5n/m6JYDAVIiN/c=;
        b=RkT1Sqi6jdOQrkcoyZkgmmvwxGNhJxt3QPX0S03lMJV2xIPCRBLZT+Xn6w8j+vomra
         HeTT2KnwxxgcCU+QZsORtCkWFA48H590jKGPFb88TA+AuquRFNIPGXIj8MPXtju55MvA
         5dtHwAnGCB+ms5YOF4k3JiyVUUHe4+VSeShq7+fhI2vH80yJ1at6LKi/cj1jPjK0FNbv
         h8t29iD+8z4uoF1V5KGfyxYQT8bB4GX6v/5PUPeF9O+5Gy/IuZAV8Z2hQj9MX+amsTn0
         JoZ9HilHiS9e9SWt47rVQ9WWM/tzaRqvsmHDnde6ZN5XfkU0G3+u/8DS0BqT+JEYxvmI
         VmCw==
X-Gm-Message-State: ANhLgQ0eL4LX1R5O2TOLHR6F2NXLHzkpq3uyppGRh5ZiQ/3qz6merC8a
        EMO0PfKX3oK5uhforiU7dzCgPbaeObI=
X-Google-Smtp-Source: ADFU+vtfMlfkEeB45UOGGHKOo85/b0PQRQySSFD7atJ9jDZzyEbbbrHHKEf8eY2f4Uf0A+L0hWidrQ==
X-Received: by 2002:a17:90b:1888:: with SMTP id mn8mr638460pjb.115.1585237636812;
        Thu, 26 Mar 2020 08:47:16 -0700 (PDT)
Received: from SARKAR ([106.51.108.92])
        by smtp.gmail.com with ESMTPSA id m2sm1950863pge.81.2020.03.26.08.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:47:16 -0700 (PDT)
Message-ID: <5e7cce84.1c69fb81.433c4.751d@mx.google.com>
X-Google-Original-Message-ID: <20200326154712.GD9520@rohitsarkar5398@gmail.com>
Date:   Thu, 26 Mar 2020 21:17:12 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     dragos.bogdan@analog.com
Cc:     linux-iio@vger.kernel.org
Subject: [GSOC] Choosing a component
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey Dragos,
I noticed that you have updated the GSOC IIO page and it mentions:
"
Create a Linux IIO driver for one of the Analog Devices, Inc.'s parts.
We are open for suggestions in identifying the exact component.
If there won’t be suggestions, or they don’t make sense, 
we will propose one component to the chosen student
"

I was wondering how to go about choosing a component.
Also if anyone amongst the IIO community has any Analog Devices
components in mind for which they want a driver written I would love
look into that.
Suggestions welcome,

Thanks,
Rohit
