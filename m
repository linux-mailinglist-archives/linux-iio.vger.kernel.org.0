Return-Path: <linux-iio+bounces-27068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D98CBB177
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 17:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0CAD301B63F
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 16:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A3622D4C3;
	Sat, 13 Dec 2025 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="lP6EboFo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877F5B21A;
	Sat, 13 Dec 2025 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765643575; cv=none; b=sKyC7ZJ9bBRS3Egp4g1jUj1Aa+Qjah++uDleFhgr8irRYpjq7Mv7OqnHSBz18pbrRTdCdPWQlwCMiXERr/s06IklmSu+odma0wLgsDepDcyTF+B2jbk2Xuu7oXUTqm6470bjf3aBO2sE6usQMtY1j+F26HaQadKDUkKjd3wx3pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765643575; c=relaxed/simple;
	bh=dwFyGZvqByH9PgzrefNl+L8Q68DGUMa9A+x/Yl0B9os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sj660UKAQYVGo2XpPe5qtX24oJUXiDGXyxhc1/gT4Ef8nc21pNJ4l1MlEZ02Pj2SUxxMZ6+8Ncn0HwVbw4KREftD/Onrf+jNaxeb/M2oVffJh+qzew/tjyqQGFfw2zOWgkr2hCoUXYrcLBuzWem6QEtBR42aF1HoUdzxO/AQxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=lP6EboFo; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1765643563; x=1766248363; i=fiona.klute@gmx.de;
	bh=dwFyGZvqByH9PgzrefNl+L8Q68DGUMa9A+x/Yl0B9os=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lP6EboForfz1aHmZrmjN9K+eie35lpgulOLbprFZqp4G+gaRKKCaLHvXrZe1bfv5
	 UZPqqZbCg/CXfOfVIFPiiRUDbwu9MmIvCqP7I/zPv3H96dlEIRgPSGvrtA5R701FE
	 qcxw6BgoreDtwHAXbthu0fH1IKu7ZnLie7c7JUUqtt7oxpkW6GcOiBmUGLRxe30+S
	 fS1PS3OO1aew4LP/m56IqBD15CflBVfdnM04KIGzLGCgcUagU9vsjHMhdfYKh2aVS
	 ecAIePhCKaTPUqsjPjZmf/rUoN8+3OBDruQ4TUPmqFGgly/sX4X6Kfr+zhwvfK1wr
	 sQyblIXc1Bmr4zUf1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.home.arpa ([85.22.18.102]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhlGq-1vz6TK3tNw-00mUd2; Sat, 13
 Dec 2025 17:32:43 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: Roan van Dijk <roan@protonic.nl>,
	linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH] iio: chemical: scd4x: fix reported channel endianness
Date: Sat, 13 Dec 2025 17:32:26 +0100
Message-ID: <20251213163226.1678707-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:7MIOzh0ALCp/oVIKfG4dek1hLzbuncYpT2yDuDt9iK//1s3nlRG
 UdkIss14CO1qSLYp4L+t18OKc36o31JmCuHufmmXNU/AvMH3TkYo/ZyfvuJraiJUE+cnlxH
 ZfiHuJG9SGjsR9+7PWQ1n12wW0jd3ZE3ibEFpzH26k6mdnjSKKcxiHuznT2pmDseWt0vgNe
 L+dvdbrEhDQFJbKQKKKQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MRKOHT0LmQM=;XkEMkNr8wwR/0zmD+HzViEPtOrw
 3ZNZ3yddHF3KBpLD1HaQ9op/ULNBBqxwuiONQn4ibkXzRlfFC3A1HK7Z3nNNb29yYlpl9b1u4
 BH+j/PbK3Mm4nZCaxyOKCi/hYmjMUV6Y2yyECTNVB3BUlGC6HVZcJ6oRKxoesN7s84OUuE0A/
 kzfuXFkiguXyRpwM8i3woHCtoQvTTCXN7q9J0bZ5mQiiMiUScrf7LHAcAGM/hJ6Nw2xLCQgg3
 hZS9SlC/BZKTmhKcKtpkmhB7TQhDtRU4jDG5koh6MYsHIjujT8rGPA8yIubchYSrnVl8wbcI6
 Zi7oDrqRBTYBNCb+2evDnawbzx7vKjTZMuVwqV35BQB6q7UT5KJCYvY80PIYEVdExBfPNbM4g
 Y1WJU8pZJg7t+aEAZBTT2b7/RAk/mQvcTHnPE/bRVNWi/DnWFwzyVNeKrsjTvzSu8JhB2eb5d
 9QploLFnxRQ82a0f1+O01djkz82sAAhPbqa9XPMvOk8c8quhNwvETLdNBAGbDCHIMX4erBHKx
 niFhQNuLqb3hx5jd8YMWV2W2cbt4ubucrp8JvzzUIBiHfvXQezufaMgW3yMclhd0aE8UVkr1N
 LgZYi0fKaKweW1lsbCcxngT5bgBrflFeffNHq6mV5/x+5uMHCovR7AvhLPBo+zNDrzaX0ETwy
 QWvwrgp0lx0VC+0/bs6cv7dD+29XcMuf3Fn+mujzFrA82O/Vx25NwUdwrIRROwr70VboZPA84
 GcbsBMqWy0ZVMRhCP8W/5frgIq4yDYcdPtod0AvBkD429BX8fAjPwQj4gkSmnUMggx4mrnSkF
 Ev2/7CWENgVY1QC2Kc6WISnz1VuW9qD32GH3n+dNKHt6dRR2o4Gi70pCrTGOKeRQ64s8U5v3n
 URI1qkdgKaPqqoG/I6kAzEoyQ4FkKilj7e/klOf4W8VyKTGKKT7SnlYaZ3/bnPVvka3HRDkch
 nVMgOO45Z0o0o6s1FGnMdRmIU1yBtOth+6QnI/5fPDXHg1uc7j+Zsk4Dj8skuiSJCeNPFWnEt
 8F/QW1Lsf6xxZ5PEUfTEtxcwGHn65lboXlXZJs/gkIpLSGLmc3XESyH0SFqBEI5d0P87AJMAK
 dA4HPpwkpyzbCdpFCi1LDk0nGz23Sqy86cqdg8eXcHebsCegURcU7UAqw/fILWcEPO2og6cjI
 Yi8vxxMVDu1BlUmnOcWUUgbErbQa19CXZs4m/7v+BoU3BRNcnxaP/tZM7CA5l6oWAmrNNpphE
 pqYBWZPwDYv9AmCMWvUnJOtYqVtomSB0wBPekMjwjNgReHhehSdUvlHu1rn5eJlaN/SkKaTvM
 QNAcuDkVMdFf45ajdLst+fYdR9ZQrhBWJkVO28yafidEu92dHsfdsHuRVoA8WXUFivY6Oc97m
 4HQAfPwqfIysW1iDSykfbHsK9kBeDS4oxNpl2C8Hlb/HbJgqWvS7HTzMn1uAxsBPh/CXfGND0
 qD9J+9KVE1LXGKN1tOvR02qnAJBJ2jDo1/j3RP4Gwd/6xe48LaxgpVSH55HSHAHKWS4c6F4S3
 SnU8HOSEB6FRWB2uyoZ3Rh6g2RRUyiGe3xh7zRcxbZI/lsAXrwCy7bve/f9V9I0SVGYSXmujL
 4F5snOQxOdKkpRE7QyIz80txlo2hxnlECh6+APtk8VNhJS1xXaFhuRhEucFy6Gnt54E8ABspw
 ktmuWYapOnK+ncOroip9JuTkovak+BLXqOZu+It5UnOkLm0Szix4DzSvKc9R2NSJngxZ6J6cb
 iyMfyOHxbMVCwqpCUZDAkGRaQ4VYXdLeXy2DliZ3LSwlYmbzysG4WymU6HtZfSusKUq779jb3
 Cwm2Wf74KLJqlvf6oAwf1XkKjwXeQCklt4dOe9WWoGo2i6rhtfHqkbLWFEkWfgvmT6fPN7LWT
 ycg1uFreC4xQk5LHmOYklRw+m1lSCDyB59+aQRDUWHtmTQCDcQTfY6lNry/MrUGH2IJKa17oB
 L2JG2jqaStsUw28N5vsVEFXQjM7YU7aKXeTyYYAoc5uApcM0o4eu8rgFOaENJLZkDNvCVy9JM
 oDHsNQhH+aHdpZF36Mj9zHvK+soVbmGBpXp3Dwt+ytwOIaSHY2XEoym/U/Ah42B1SEVdvr6qF
 5Hk2p831mORLzI55nxpZyOMdXALay1L004halazrGdRQoZ8oAgASHw6f0xyMda0EqE+9o6PwU
 ZIEng8eSrP4kMUzEDL93uUDM6CfA+qKCM39P1e859oNkfwcBaVY+uEyoB4M1F4ANPuDD4EH9h
 7gQfqijOEwWSXCY1t8rNkzN9DTQqKsEkHmJK971CyxiQwURIh8iF4Ysj5Ok/3rthZmQi5sOrM
 WwYv2RihF/kBVb9G/IdX9RGJHJRYukWH0dk26Lw2kE8aSATA5hQXnsz4eg6rfGVWkYONZPXNB
 xU3nqCZgquSrCvcurrLoJTqnHIHHl05YD76XdbsMgnpIMnojcEj7IJX3q1bxoLLNeqhKmoe/Y
 B7Dpw85ibBldo3KKJYu7d9RJQ4+fMYC9FAN0fccl6plkV3k0N7/9UMaxdgQgVXiiSLm7uIZle
 eL4rS05KDmiAHB9r3TiKhJmDbEnsUrmbOOZwo+IQG7lN9lyMVWygrduKvClpIjmDECf7AwKcP
 5YgO7TX0tZw1a2mmJgpfqpDuFJmFDqUJFykR/1HmsP6ytMV7mwgkvfsP6g2VIbsWlbvdVg5hn
 Qv8k9MRcZVTDDurScfwcPR5le8DY49D4gDblIGWMkY+14wOTHYQvLAbohK0AcQ6GN6j43pSD8
 XjzmtzGKddz9UtoWYQaP/eel3TvpLDFvf9BPHriujtyM0J1A9rzz6gOGZiEslq1akTaihmUIQ
 3JyIZbMGkews+z//0N/rpExai9ROjJ04IBMooW6HVsgSH2AU25yHx12kiFZJ0zDFOB5hJminy
 SS8RBn1hnR2BZgOAxbF43FjEq/4G0z90ulPk3kus235SQ42fblk49toOKoNItLuKIrVQJONmo
 IwhCxukBV8yCyoPufHKkx0PwOGUMuz3vV0wcVDs1m/+kN7K1dsoHopC42L4jTnYYyh9d3YZZp
 jdkEH3EbQt1mMdxQcGEoXGBqb02HnyXgqL7y42+msL7y5foNGpvmW7cRo8tYOsWqw8twxPlJm
 5a0CDMusEnV+Y92pjZBp4tqNce5N548SwLzDAlQhda+2hngTn5/7lNnkqjQlzK0vPzIGKiJAi
 Pk4a/S+EfyjExVItbAgdJw8kg5fnXo2/09GGbBF3FHR4bwI5AGFs3FAgNOc3WUZ0PP3rU7IaF
 82axmqSRpR271bmDTmN8fKoiD4S8rWVhnx0KfCzcQXHxI9MCcPBQ9iB9Jxj/yOZ0/U9UOFIEd
 f5N1uVbIWQIQB4AlkJupVb/XzTcaBf/CQadKeE5BCvAazVcX2qhvr2K87Vn5oQ2enoIVn+3lP
 c668x9cmCV0Vox3YyQgulsbnt2X8o6EIp09PUNYP7Unt95mINFSONk8AsXkSQ8vR1Lay3onmJ
 +bJx4zxwqIYDk3+apE4Od8ZVpZYJx2s6TNAF0s0RJGrbceYPbsz49OtOGdVdEb9cf1vbILihY
 QpDEdJt3nB5iVAgRnX4KAKgPmByb/Iq2mB0D4Gm+UErWA/L6ItKxugodCzJJDBO4yfPpOK9xi
 pyQpn465EKtIKd6XgK3/auBf/zh/w8S7Orv4yjT25sNfr/JL0HXwi2N/keBiZVY/C8xZC5IKo
 lUP5QJHhlAjshrxtxTnfVcloxgjnDkY++6ug8OU8z/Xc1UFfYlFpEEsThKmQ7jTp5Ca4tfmBc
 JwKbl5BonUZcpMz80UKrfkpagKTmXhRFWIRB1Wn060HV2Z0C5xy1ZRDeFfMzd5jwu7JP58//J
 dMYZPJXE0ZLYUIdPM2zdSJhDlVOTslSEti67mi9JgmSM5ZmywgZBVAMtJ2bJqcZGJpIuthd3K
 T9iokc2IMt+SrGJ7S3XVsuQ1N+EpmllEbuThZugRHQ6dzZapXQdfTmxKiBT/n5l6gvCS+uOYU
 Z2sSQqYfKbzNltWmUDAvMeqhCb0GuyXz1mJ63Kg+hxUvVF9GJawwT/Y6Wz7RIMACP2z5H6bYD
 vHvBtnTeZQxAkyD0V63q0X8Ugwrss5Dd0qJyX1lB9GRMsJwzebKdEu1HeuAiF+yrzANWanAcK
 RU1XG67Ed12nC5HMl+StdeKEHB46tPcwvHZaMeq07/AHggdVGq4ClfVpdnS1UEVxe1+tItJTA
 9okJugL62dEmWB/keqhGnuXPNn+pI2hXJ+9a1kY8WCI697c791+e1YGvlKq5PwFyIJxGsY1cE
 RTcBtE85ZDbFMpy+5sCpCNUhQo8xUoe41sMeFIMonlOmlZ6gcdfjShYjUcZwzC6mRNoz5Jf1m
 Hu9KCtKJzJSYiATbW8XDJCcotoWKVgzxIiQRLSmEbtmuk6+0knShV3fmzWnzl6+k+jPJ2lbIx
 iquGpBRtLifi5iOVThaqkKNQD1C2Nz+SmCAO76dI5LBwmpaWjxMZcdjCtb77JhFIGMH8ecIRc
 ls+9FOre59T3LPFlLeLETVyo9cgug/kN092s40Usu0wuB+iwE60Voxj+vPAryv+GHM24HwzFE
 Hll9yp5KIZItPJx8kslQDAktgA0Ge3v/WQ52d61VNljrhKZckNrHFniTH7nXd7sATr6y1FQ3x
 ROGQWyaVEWHUREvxryZwHBaI0KfCUpc7o+UN6UmlfegmGjNqEQv4MZRv6EOmfdY9zNt/d/XSt
 6M3HoB3D0yaXDLj8laabEfG3Aj/qCfFN3UfaY6S93PvJtR6MKEvanUIl/vnu72UF+/lp7fX90
 W5QqHkcAw8d4mqlGa9TMvzanyVDgLY6qcbmYlUZTcavEy9vOlA3lW18x1Nhz3X+V1yVStP96t
 RDMFy3GFB9G9PuL1B4YIiWJ/+cgVCPjOTtVFDGHOJgS+JvQCUPPIrDQrQQu7wKO8cdIWgdXEv
 dkSr5Q75J/MKGqP6sPftv21WKfvYd64iHNb5Y6s8HIWuwmRQPV10h4V03fVh2LBbFOuN0keXC
 jljJo0CMCzTSlwTS0wPdmA9imhbXfKoIdfNjuA1VoMll/8Py0RjzWnHA6ZHn68VnOUTN+EsZr
 EQtPTN5/Dn4JSdSH2AX2JSmkn/d6/L/SOYoJpE/z6johh7pneLrAcTj+ktQNjdMj4mFR/Mi7P
 TRkXt2/DWA1cKZSg5T+rIAVjHrygIlNgiz2HhLM2viNIo2WvmBWT0YPnKYGfYmfz/7bfSJc4y
 HW+eLjYaCqdxI8EhkaGfYxRUycB4G1fCcG22tqOAV2YORHnronw==

VGhlIGRyaXZlciBjb252ZXJ0cyB2YWx1ZXMgcmVhZCBmcm9tIHRoZSBzZW5zb3IgZnJvbSBCRSB0
byBDUFUKZW5kaWFubmVzcyBpbiBzY2Q0eF9yZWFkX21lYXMoKS4gVGhlIHJlc3VsdCBpcyB0aGVu
IHB1c2hlZCBpbnRvIHRoZQpidWZmZXIgaW4gc2NkNHhfdHJpZ2dlcl9oYW5kbGVyKCksIHNvIG9u
IExFIGFyY2hpdGVjdHVyZXMgcGFyc2luZyB0aGUKYnVmZmVyIHVzaW5nIHRoZSByZXBvcnRlZCBC
RSB0eXBlIGdhdmUgd3JvbmcgcmVzdWx0cy4KCnNjZDR4X3JlYWRfcmF3KCkgd2hpY2ggcHJvdmlk
ZXMgc3lzZnMgKl9yYXcgdmFsdWVzIGlzIG5vdCBhZmZlY3RlZCwgaXQKdXNlZCB0aGUgdmFsdWVz
IHJldHVybmVkIGJ5IHNjZDR4X3JlYWRfbWVhcygpIHdpdGhvdXQgZnVydGhlcgpjb252ZXJzaW9u
LgoKRml4ZXM6IDQ5ZDIyYjY5NWNiYjYgKCJkcml2ZXJzOiBpaW86IGNoZW1pY2FsOiBBZGQgc3Vw
cG9ydCBmb3IgU2Vuc2lyaW9uIFNDRDR4IENPMiBzZW5zb3IiKQpTaWduZWQtb2ZmLWJ5OiBGaW9u
YSBLbHV0ZSA8ZmlvbmEua2x1dGVAZ214LmRlPgotLS0KIGRyaXZlcnMvaWlvL2NoZW1pY2FsL3Nj
ZDR4LmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9jaGVtaWNhbC9zY2Q0eC5jIGIvZHJp
dmVycy9paW8vY2hlbWljYWwvc2NkNHguYwppbmRleCA4ODU5Zjg5ZmIyYTk0Li4wZmQ4MzkxNzZl
MjY0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lpby9jaGVtaWNhbC9zY2Q0eC5jCisrKyBiL2RyaXZl
cnMvaWlvL2NoZW1pY2FsL3NjZDR4LmMKQEAgLTU4NCw3ICs1ODQsNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGlpb19jaGFuX3NwZWMgc2NkNHhfY2hhbm5lbHNbXSA9IHsKIAkJCS5zaWduID0gJ3Un
LAogCQkJLnJlYWxiaXRzID0gMTYsCiAJCQkuc3RvcmFnZWJpdHMgPSAxNiwKLQkJCS5lbmRpYW5u
ZXNzID0gSUlPX0JFLAorCQkJLmVuZGlhbm5lc3MgPSBJSU9fQ1BVLAogCQl9LAogCX0sCiAJewpA
QCAtNTk5LDcgKzU5OSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBzY2Q0
eF9jaGFubmVsc1tdID0gewogCQkJLnNpZ24gPSAndScsCiAJCQkucmVhbGJpdHMgPSAxNiwKIAkJ
CS5zdG9yYWdlYml0cyA9IDE2LAotCQkJLmVuZGlhbm5lc3MgPSBJSU9fQkUsCisJCQkuZW5kaWFu
bmVzcyA9IElJT19DUFUsCiAJCX0sCiAJfSwKIAl7CkBAIC02MTIsNyArNjEyLDcgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjIHNjZDR4X2NoYW5uZWxzW10gPSB7CiAJCQkuc2ln
biA9ICd1JywKIAkJCS5yZWFsYml0cyA9IDE2LAogCQkJLnN0b3JhZ2ViaXRzID0gMTYsCi0JCQku
ZW5kaWFubmVzcyA9IElJT19CRSwKKwkJCS5lbmRpYW5uZXNzID0gSUlPX0NQVSwKIAkJfSwKIAl9
LAogfTsKLS0gCjIuNTEuMAoK

